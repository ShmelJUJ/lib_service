import { createContext, useState } from 'react'
import { Outlet } from 'react-router-dom'
import { ToastContainer } from 'react-toastify'
import 'react-toastify/dist/ReactToastify.css'
import './App.css'
import Footer from './component/Footer.jsx'
import Header from './component/Header.jsx'

export const api = '/api/'

export const AuthContext = createContext({
	isAuth: false,
	setAuth: () => {},
	user: {},
	setUser: () => {},
})

export default function App() {
	const [isAuth, setAuth] = useState(false)
	const [user, setUser] = useState({})

	return (
		<>
			<AuthContext.Provider value={{ isAuth, setAuth, user, setUser }}>
				<Header />
				<div className='page'>
					<Outlet />
				</div>
				<Footer />
			</AuthContext.Provider>
			<ToastContainer
				position='bottom-right'
				autoClose={5000}
				hideProgressBar={false}
				newestOnTop={false}
				closeOnClick
				rtl={false}
				pauseOnFocusLoss
				draggable
				pauseOnHover
				theme='dark'
			/>
		</>
	)
}
