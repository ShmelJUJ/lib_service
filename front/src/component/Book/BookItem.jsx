import { useContext, useEffect, useState } from 'react'
import { toast } from 'react-toastify'
import { AuthContext } from '../../App'
import BookAssignModal from './BookAssignModal'
import './style.css'

export default function BookItem({ book, setUpdate }) {
	const [isVisible, setVisible] = useState(false)
	const { user, isAuth } = useContext(AuthContext)

	useEffect(() => {
		setUpdate(!isVisible)
	}, [isVisible])

	return (
		<tr className='book__item'>
			<td className='book__title'>{book.title}</td>
			<td className='book__date'>{book.release_date.substr(0, 4) + ' г.'}</td>
			<td className='book__authors'>
				{book.authors
					.map(author => {
						return author.full_name
					})
					.join(', ')}
			</td>
			<td className='book__genre'>{book.genre}</td>
			<td className='book__amount'>
				{book.amount > 0 ? (
					<div
						className='button'
						onClick={() => {
							isAuth ? setVisible(true) : toast.warning('Авторизуйтесь!!!')
						}}
					>
						Взять
					</div>
				) : (
					<div
						className='button blue__button'
						onClick={() => toast.error('Данной книги нет в наличии!!!')}
					>
						Отсутсвует
					</div>
				)}
			</td>
			<BookAssignModal
				isVisible={isVisible}
				setVisible={setVisible}
				book={book}
			/>
		</tr>
	)
}
