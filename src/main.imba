import { MealApp } from './components/MealApp'
import data from "../recipes.json"
  
tag app
	def mount
		document.title = "Meals App"
	
	def addStylesheet href
		let link = document.createElement("link")
		link.rel = "stylesheet"
		link.href = href
		document.head.appendChild(link)
	
	<self[ff:fantasy]>
		<MealApp recipes=data>

imba.mount <app>
