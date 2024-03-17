import { useContext, useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { AuthContext, api } from '../../App'
import UserBookItem from './UserBookItem'

export default function UserPage() {
	const [reservations, setReservations] = useState([])
	const { user } = useContext(AuthContext)
	const [needUpdate, setUpdate] = useState(false)

	const navigate = useNavigate()

	const fetchReservations = async () => {
		if (typeof user['user_id'] === 'undefined') {
			navigate('/')
			return
		}
		const param = new URLSearchParams({
			user_id: user.user_id,
		})

		const resp = await fetch(api + `reserv_pr?${param}`, {
			method: 'GET',
		})

		console.log(resp)

		const data = await resp.json()
		console.log(data)
		setReservations(data)
		setUpdate(false)
	}

	useEffect(() => {
		fetchReservations()
	}, [])

	useEffect(() => {
		if (!needUpdate) return
		fetchReservations()
	}, [needUpdate])

	return (
		<div className='page__inner'>
			<table className={'books__container'}>
				<tr className='book__item table__header'>
					<th className='book__title'>Название</th>
					<th className='book__date'>Год выпуска</th>
					<th className='book__user__dates'>Даты бронирования</th>
					<th className='book__amount'></th>
				</tr>
				{reservations.map(reserv => {
					return <UserBookItem reservation={reserv} setUpdate={setUpdate} />
				})}
			</table>
		</div>
	)
}
