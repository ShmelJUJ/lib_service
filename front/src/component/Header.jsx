import logo from '../../img/logo.svg'
import './Main.css'

import { useContext, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { AuthContext } from '../App'
import { AuthModal, RegModal } from './UserPages/Auth'

export default function Header() {
	const [regModal, setRegModal] = useState(false)
	const [authModal, setAuthModal] = useState(false)
	const { isAuth, user } = useContext(AuthContext)
	const navigate = useNavigate()
	return (
		<header>
			<div className={'header__inner'}>
				<div className={'header__logo'} onClick={() => navigate('')}>
					<img className={'logo'} src={logo} alt='Ilia Library' />
					<div>Библиотека</div>
				</div>
				<div className={'header__userInfo'}>
					{isAuth ? (
						<>
							<div className='button' onClick={() => navigate('userInfo')}>
								{user.login}
							</div>
						</>
					) : (
						<>
							<div className={'button'} onClick={() => setAuthModal(true)}>
								Вход
							</div>
							<div className={'button'} onClick={() => setRegModal(true)}>
								Регистрация
							</div>
						</>
					)}
				</div>
			</div>
			<RegModal setRegModal={setRegModal} regModal={regModal} />
			<AuthModal setAuthModal={setAuthModal} authModal={authModal} />
		</header>
	)
}
