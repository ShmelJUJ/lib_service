import { useEffect, useState } from 'react'
import search_img from '../../../img/search.svg'
import { api } from '../../App'
import BookItem from './BookItem'
import './style.css'

export default function BooksPage() {
	const [books, setBooks] = useState([])
	const [needUpdate, setUpdate] = useState(false)

	const [author, setAuthor] = useState('')
	const [book, setBook] = useState('')

	const fetchBooks = async (book = '', author = '') => {
		try {
			const param = new URLSearchParams({
				book_name: book,
				author_name: author,
			})
			const resp = await fetch(api + `books?${param}`, {
				method: 'GET',
			})
			console.log(resp)
			if (!resp.ok) {
				throw new Error('плохой запрос')
			}
			const data = await resp.json()
			console.log(data)
			setBooks(data)
		} catch (error) {
			console.log(error)
		}
	}

	useEffect(() => {
		fetchBooks()
	}, [])

	useEffect(() => {
		if (!needUpdate) return
		fetchBooks()
	}, [needUpdate])

	return (
		<div className='page__inner'>
			<div className={'search__container'}>
				<div className={'inputContainer'}>
					<div style={{ whiteSpace: 'nowrap' }}>Название книги:</div>
					<input value={book} onChange={e => setBook(e.target.value)} />
				</div>
				<div className={'inputContainer'}>
					<span>Автор:</span>
					<input value={author} onChange={e => setAuthor(e.target.value)} />
				</div>
				<div className='search_btn' onClick={() => fetchBooks(book, author)}>
					<img className='search_img' src={search_img} />
				</div>
			</div>
			<table className={'books__container'}>
				<tr className='book__item table__header'>
					<th className='book__title'>Название</th>
					<th className='book__date'>Год выпуска</th>
					<th className='book__authors'>Авторы</th>
					<th className='book__genre'>Жанр</th>
					<th className='book__amount'>Наличие</th>
				</tr>
				{books.map(book => {
					return <BookItem book={book} setUpdate={setUpdate} />
				})}
			</table>
		</div>
	)
}
