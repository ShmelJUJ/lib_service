import { toast } from 'react-toastify'
import { api } from '../../App'
import './style.css'

var options = {
	year: 'numeric',
	month: 'long',
	day: 'numeric',
}

export default function UserBookItem({ reservation, setUpdate }) {
	const fetchReturnBook = async () => {
		const param = new URLSearchParams({
			issuance_id: reservation.issuance_id,
		})

		const resp = await fetch(api + `reserv_ret?${param}`, {
			method: 'PUT',
		})

		console.log(resp)

		const data = await resp.json()

		console.log(data)
		toast.success('Бронирование отменено')
		setUpdate(true)
	}

	return (
		<tr className='book__item'>
			<td className='book__title'>{reservation.title}</td>
			<td className='book__date'>
				{reservation.release_date.substr(0, 4) + ' г.'}
			</td>
			<td className='book__user__dates'>
				{reservation.issuance_date + ' - ' + reservation.deadline_date}
			</td>
			<td className='book__button'>
				<div className='button' onClick={() => fetchReturnBook()}>
					Отменить
				</div>
			</td>
		</tr>
	)
}
