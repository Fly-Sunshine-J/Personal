import {Dimensions,} from 'react-native'

export default class Common {
    static screenWidth = Dimensions.get('window').width
    static screenHeight = Dimensions.get('window').height
}