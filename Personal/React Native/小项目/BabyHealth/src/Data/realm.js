import Realm from 'realm'

class Item extends Realm.Object {}

Item.schema = {
    name: 'Item',
    primaryKey: 'id',
    properties: {
        id: 'string',
        prompt: 'string',
        symptoms: 'string',
        ingredients: 'string',
        lock: 'string',
        month: 'string',
        practice: 'string',
        name: 'string',
    },
}


export default new Realm({schema: [Item]})