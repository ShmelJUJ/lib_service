import { useContext, useState } from 'react'
import { toast } from 'react-toastify'
import { AuthContext, api } from '../../App'
import { Modal } from '../Modal/Modal'

function UserForm({ login, setLogin, pass, setPass }) {
	return (
		<form className='userForm'>
			<div className={'inputContainer'}>
				<span>Логин:</span>
				<input value={login} onChange={e => setLogin(e.target.value)} />
			</div>
			<div className={'inputContainer'}>
				<span>Пароль:</span>
				<input
					type='password'
					value={pass}
					onChange={e => setPass(e.target.value)}
				/>
			</div>
		</form>
	)
}

export function RegModal({ regModal, setRegModal }) {
	const [login, setLogin] = useState('')
	const [pass, setPass] = useState('')
	const { isAuth, setAuth, user, setUser } = useContext(AuthContext)
	const [isDisable, setDisable] = useState(false)

	const regBtnClick = async () => {
		setDisable(true)
		const param = new URLSearchParams({
			login: login,
			password: pass,
		})
		const resp = await fetch(api + `reg?${param}`, {
			method: 'POST',
		})
		console.log(resp)
		if (resp.body == null) {
			toast.warning('Пользователь с таким логином или паролем не найден!!!')
			setDisable(false)
			return
		}
		const data = await resp.json()
		console.log(data)
		if (typeof data['message'] !== 'undefined') {
			setDisable(false)
			toast.error('Пользователь с таким логином уже существует!!!')
			return
		}
		setAuth(true)
		setUser(data[0])
		setDisable(false)
		setRegModal(false)
	}
	return (
		<Modal
			isVisible={regModal}
			title='Регистрация'
			content={
				<UserForm
					login={login}
					pass={pass}
					setLogin={setLogin}
					setPass={setPass}
				/>
			}
			footer={
				<button
					className={'button'}
					onClick={() => regBtnClick()}
					disable={!isDisable}
				>
					Регистрация
				</button>
			}
			onClose={() => setRegModal(false)}
		/>
	)
}

export function AuthModal({ authModal, setAuthModal }) {
	const [login, setLogin] = useState('')
	const [pass, setPass] = useState('')

	const { user, setUser, isAuth, setAuth } = useContext(AuthContext)
	const [isDisable, setDisable] = useState(false)

	const authBtnClick = async () => {
		setDisable(true)
		const param = new URLSearchParams({
			login: login,
			password: pass,
		})
		const resp = await fetch(api + `auth?${param}`, {
			method: 'GET',
		})
		console.log(resp)

		const data = await resp.json()
		console.log(data)
		if (typeof data['message'] !== 'undefined') {
			toast.warning('Пользователь с таким логином или паролем не найден!!!')
			setDisable(false)
			return
		}

		setAuth(true)
		setUser(data[0])
		setDisable(false)
		setAuthModal(false)
	}

	return (
		<Modal
			isVisible={authModal}
			title='Вход'
			content={
				<UserForm
					login={login}
					pass={pass}
					setLogin={setLogin}
					setPass={setPass}
				/>
			}
			footer={
				<div
					className={'button'}
					onClick={() => authBtnClick()}
					disable={!isDisable}
				>
					Войти
				</div>
			}
			onClose={() => setAuthModal(false)}
		/>
	)
}
