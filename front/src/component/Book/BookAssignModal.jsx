import { useContext, useState } from 'react'
import DatePicker from 'react-datepicker'
import 'react-datepicker/dist/react-datepicker.css'
import { AuthContext, api } from '../../App'
import { Modal } from '../Modal/Modal'

var options = {
	weekday: 'long',
	year: 'numeric',
	month: 'long',
	day: 'numeric',
}

function addMonths(date, months) {
	date = new Date(date)
	date.setMonth(date.getMonth() + months)
	return date
}

function BookAssign({ book, startDate, endDate, setEndDate }) {
	return (
		<div className='book__info__container'>
			<div className='book__short__info'>
				{book.title + ' (' + book.release_date.substr(0, 4) + ' г.)'}
			</div>
			<div className='endDate__container'>
				<div>Время сдачи: </div>
				<DatePicker
					selectsEnd
					className='datepicker'
					selected={endDate}
					onChange={date => setEndDate(date)}
					endDate={endDate}
					startDate={startDate}
					value={endDate.toLocaleDateString('ru-RU', options)}
					minDate={startDate}
					maxDate={addMonths(startDate, 2)}
				/>
			</div>
		</div>
	)
}

export default function BookAssignModal({ isVisible, setVisible, book }) {
	const [startDate, setStartDate] = useState(new Date())
	const [endDate, setEndDate] = useState(new Date())
	const [isDisable, setDisable] = useState(false)

	const { user } = useContext(AuthContext)

	const sentFun = async () => {
		if (isDisable) return

		setDisable(true)
		const reserv = {
			book_id: book.book_id,
			start_date: startDate.toISOString().substring(0, 10),
			end_date: endDate.toISOString().substring(0, 10),
			user_id: user.user_id,
		}
		console.log(reserv)
		const param = new URLSearchParams(reserv)
		const resp = await fetch(api + `reserv_add?${param}`, {
			method: 'POST',
		})
		console.log(resp)
		const data = await resp.json()
		console.log(data)

		setDisable(false)
		setVisible(false)
	}

	return (
		<Modal
			isVisible={isVisible}
			title='Оформление книги'
			content={
				<BookAssign
					book={book}
					endDate={endDate}
					setEndDate={setEndDate}
					startDate={startDate}
				/>
			}
			footer={
				<div
					className={'button'}
					onClick={() => {
						sentFun()
					}}
				>
					Забронировать
				</div>
			}
			onClose={() => setVisible(false)}
		/>
	)
}
