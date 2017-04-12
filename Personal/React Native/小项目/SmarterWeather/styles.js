import {
    StyleSheet,
} from 'react-native'

const baseFontSize = 18;

const styles = StyleSheet.create({
    buttonStyle: {
        backgroundColor: '#FFDDFF',
        width: 200,
        padding: 24,
        borderRadius: 5,
        alignItems: 'center',
    },
    bigText: {
        fontSize: baseFontSize + 8,
        color: '#FFFFFF'
    },
    mainText: {
        fontSize: baseFontSize,
        color: '#FFFFFF'
    },
    backdrop: {
        flex: 1,
        flexDirection: 'column'
    }
});

export default styles