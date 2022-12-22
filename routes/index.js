const { Router } = require("express");
const { getPizzas, getPizzasByName, postCreatePizza, putUpdatePizza, deletePizza, getIngredients, postCreateIngredients, putUpdateIngredients, deleteIngredients, getPizzaIngredients, postCreatePizzaIngredients, getIngredientByPizza, getPizzaWithIngredients, getPizzasIngredientsByPizzaId, deletePizzaIngredients } = require("../controller/pizza.controller");

const router= Router()
router.get("/pizzas",getPizzas)
router.get("/pizzas/:name",getPizzasByName)
router.post("/pizzas",postCreatePizza)
router.put("/pizzas",putUpdatePizza)
router.delete("/pizzas",deletePizza)
router.get("/pizzasWithIngredients",getPizzaWithIngredients)
//ingredients
router.get("/ingredients",getIngredients)
router.post("/ingredients",postCreateIngredients)
router.put("/ingredients",putUpdateIngredients)
router.delete("/ingredients",deleteIngredients)
//pizza ingredients
router.get("/pizzas_ingredients",getPizzaIngredients)
router.post("/pizzas_ingredients",postCreatePizzaIngredients)
router.get("/pizzas_ingredients/:id",getPizzasIngredientsByPizzaId)
router.delete("/pizzas_ingredients",deletePizzaIngredients)

module.exports=router