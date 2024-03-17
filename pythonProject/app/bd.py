import psycopg2
from psycopg2.extras import RealDictCursor

def connection():
    conn = psycopg2.connect(host='db',
    dbname='lib',
    user='postgres',
    password='postgres',
    port=5432,
    cursor_factory=RealDictCursor)
    return conn.cursor()




