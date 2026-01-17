import { RecipeCard } from './RecipeCard'

export tag MealApp
	recipes\Recipe[] = []

	_mealTypes = {
		"mealType-breakfast": "Desayuno"
		"mealType-snack": "Colacion"
		"mealType-lunch": "Almuerzo"
		"mealType-afternoon-snack": "Merienda"
		"mealType-dinner": "Cena"
		"mealType-dessert": "Postre"
	}
	_meals = []

	@observable _prefMealType
	@observable _prefUserDiet
	@observable _prefUserHealth
	
	def setup
		const localStorage = window.localStorage
		_prefMealType = localStorage.getItem("mealApp.prefMealType") || ""
		_prefUserDiet = localStorage.getItem("mealApp.prefUserDiet") || ""
		_prefUserHealth = localStorage.getItem("mealApp.prefUserHealth") || ""

	@autorun def _savePrefs
		const localStorage = window.localStorage
		localStorage.setItem("mealApp.prefMealType", _prefMealType)
		localStorage.setItem("mealApp.prefUserDiet", _prefUserDiet)
		localStorage.setItem("mealApp.prefUserHealth", _prefUserHealth)

	@autorun def _selectMeals
		_meals = _groupByMeal(_filter(recipes))
	
	def _filter(recipes)
		if _prefMealType
			recipes = recipes.filter do(rec)
				rec.labelsId && rec.labelsId.includes(_prefMealType)
		if _prefUserDiet
			recipes = recipes.filter do(rec)
				rec.labelsId && rec.labelsId.includes(_prefUserDiet)
		if _prefUserHealth
			recipes = recipes.filter do(rec)
				rec.labelsId && rec.labelsId.includes(_prefUserHealth)
		recipes
	
	def _groupByMeal(recipes)
		let meals = []
		for own key of _mealTypes
			const meal = {
				type: _mealTypes[key]
				index: 0
				recipes: recipes.filter do(rec)
					rec.labelsId && rec.labelsId.includes(key)
			}
			meal.index = Math.floor(Math.random() * meal.recipes.length)
			meals.push(meal)
		meals
	
	get _totalCalories
		let total = 0
		for meal of _meals
			if meal.recipes.length > 0
				const recipe = meal.recipes[meal.index % meal.recipes.length]
				if recipe.calories
					total += recipe.calories
		total
	
	<self>
		<h1> "Meals"
		<section>
			<h3> "Preferencias"
			<[d:flex fld:row flw:wrap g:1em]>
				css label d:block w:max-content
				<fieldset>
					<legend> "Tipo"
					<label>
						<input bind=_prefMealType type="radio" name="recipeType" value="">
						"Sin preferencia"
					<label>
						<input bind=_prefMealType type="radio" name="recipeType" value="recipeType-food">
						"Alimento"
					<label>
						<input bind=_prefMealType type="radio" name="recipeType" value="recipeType-recipe">
						"Receta"
				<fieldset>
					<legend> "Dieta"
					<label>
						<input bind=_prefUserDiet type="radio" name="userDiet" value="">
						"Sin preferencia"
					<label>
						<input bind=_prefUserDiet type="radio" name="userDiet" value="userDiet-vegetarian">
						"Vegetariano"
					<label>
						<input bind=_prefUserDiet type="radio" name="userDiet" value="userDiet-vegan">
						"Vegano"
				<fieldset>
					<legend> "Salud"
					<label>
						<input bind=_prefUserHealth type="checkbox" name="glutenFree" value="userHealth-gluten-free">
						"Sin gluten"
				<p> _totalCalories + " kcal"
				<button @click=_selectMeals> "Refresh"
		<section>
			<h2> "Selección de comidas"
			<[d:grid gtc:repeat(auto-fit, minmax(300px, 1fr)) g:1em]>
				for meal of _meals when meal.recipes.length > 0
					<article>
						<h3> meal.type
						<RecipeCard recipe=meal.recipes[meal.index % meal.recipes.length]>