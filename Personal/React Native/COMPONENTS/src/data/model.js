export default class Model {
    constructor(name, image) {
        this.name = name;
        this.imageSource = image;
    }

    setFromObject(ob) {
        this.imageSource = ob.imageSource;
        this.name = ob.name;
    }

    static fromObject(ob) {
        let model = new Model(ob.name, ob.imageSource);
        model.setFromObject(ob);
        return model;
    }
}