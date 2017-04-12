
export default class Model {
    constructor(prompt, symptoms, id, ingredients, lock, month, practice, name) {

        this.prompt = prompt;
        this.symptoms = symptoms;
        this.id = id;
        this.ingredients = ingredients;
        this.lock = lock;
        this.month = month;
        this.practice = practice;
        this.name = name;
    }

    setFromItem(Item) {
        this.prompt = Item.prompt;
        this.symptoms = Item.symptoms;
        this.id = Item.id;
        this.ingredients = Item.ingredients;
        this.lock = Item.lock;
        this.month = Item.month;
        this.practice = Item.practice;
        this.name = Item.name;
    }

    static fromItem(item) {
        let model = new Model()
        model.setFromItem(item);
        return model;
    }
}