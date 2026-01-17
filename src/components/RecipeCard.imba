export tag RecipeCard
	recipe\Recipe

	<self[rd:lg bxs:lg of:hidden]>
		<[w:100% h:150px of:hidden bgc:cool1]> if recipe.images && recipe.images.length > 0
			<img[w:100% h:100% object-fit:cover] src=recipe.images[0].value alt=recipe.title>
		<[px:1em]>
			<h4> recipe.title
			<[d:flex fld:row g:2em]>
				<p> recipe.prepTime + " min" if recipe.prepTime
				<p> recipe.calories + " kcal" if recipe.calories
			if recipe.ingredients
				<p>
					<b> "Ingredientes: "
					recipe.ingredients
			if recipe.instructions
				<p>
					<b> "Instrucciones: "
					recipe.instructions