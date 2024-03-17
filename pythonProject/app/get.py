from fastapi import APIRouter, Response
from argon2 import PasswordHasher
from datetime import date

from fastapi.responses import JSONResponse
from fastapi.encoders import jsonable_encoder

from app.bd import connection


rout = APIRouter()

ph = PasswordHasher()

@rout.get("/books")
def read_books(book_name:str | None = "", author_name: str | None = ""):
    cur = connection()
    cur.execute(f"""SELECT books.book_id, title, release_date, genre, amount, json_agg(author.*) as authors
FROM books
JOIN author_book ON books.book_id=author_book.book_id
JOIN author ON author_book.author_id=author.author_id
WHERE LOWER(title) LIKE LOWER('%{book_name}%') and LOWER(full_name) LIKE LOWER('%{author_name}%')
GROUP BY books.book_id, title, release_date, genre, amount""")
    books = cur.fetchall()
    return books

@rout.post("/reg")
def registration(login: str = "", password: str = "") -> Response:
    cur = connection()
    cur.execute(f"""SELECT login FROM users WHERE login = '{login}'""")
    info = cur.fetchall()
    print(len(info))
    if len(info) > 0:
        print(info)
        cur.close()
        return JSONResponse(content={"message": "Пользователь с таким логином уже существует"})
    cur.execute(f"""INSERT INTO users (login, pass, user_role) VALUES (%s, %s, %s)""", (login, ph.hash(password), 'user'))
    cur.connection.commit()
    cur.execute(f"""SELECT user_id, login, user_role FROM users WHERE login='{login}'""")
    info = cur.fetchall()
    cur.close()

    return JSONResponse(content=jsonable_encoder(info))

@rout.get("/auth")
def auth(login:str | None = "", password:str | None = "") -> Response:
    cur = connection()
    cur.execute(f"SELECT login, user_id, pass FROM users WHERE login='{login}'")
    info = cur.fetchall()
    if len(info) == 0:
        #print('test')
        cur.close()
        return JSONResponse(content={"message": "User not found"})
    user = info[0]
    print(user)
    if not ph.verify(user['pass'], password):
        cur.close()
        return JSONResponse(content={"message": "Неверный пароль"})
    del user['pass']
    cur.close()
    return info


@rout.post("/reserv_add")
def reserv_add(book_id:int, start_date:date, end_date:date, user_id:int):
    cur = connection()
    cur.execute(f"""INSERT INTO issuance(book_id, issuance_date, deadline_date, user_id, is_returned)
        VALUES (%s ,%s ,%s ,%s , FALSE)""", (book_id, start_date, end_date, user_id))
    cur.execute(f"""UPDATE books SET amount=amount-1 WHERE book_id={book_id}""")
    cur.connection.commit()
    cur.close()
    return 'success'

@rout.get("/reserv_pr")
def reserv_print(user_id:int):
    cur = connection()
    cur.execute(f"""SELECT *
        FROM issuance
        JOIN books ON issuance.book_id=books.book_id
        WHERE user_id={user_id} AND is_returned = FALSE""")
    info = cur.fetchall()
    cur.close()
    return info

@rout.put("/reserv_ret")
def reserv_return(issuance_id:int):
    cur = connection()
    cur.execute(f"""UPDATE issuance
        SET is_returned = TRUE
        WHERE issuance_id={issuance_id}""")
    cur.execute(f"""UPDATE books SET amount=amount+1 WHERE book_id=(SELECT book_id FROM issuance WHERE issuance_id={issuance_id})""")
    cur.connection.commit()
    cur.close()
    return 'success'

@rout.get("/info")
def info(user_id:int):
    cur = connection()
    if (user_id == None):
        cur.execute("SELECT user_id, login FROM users")
    else:
        cur.execute(f"SELECT user_id, login FROM users WHERE user_id={user_id}")
    info = cur.fetchall()
    cur.close()
    return info