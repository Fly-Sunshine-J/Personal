import React, {Component} from 'react'
import {
    CameraRoll,
    Image,
    Slider,
    StyleSheet,
    Switch,
    Text,
    View,
    TouchableOpacity,
    ListView,
} from 'react-native'

import CamerarollView from './CameraRollView'

const CAMERA_ROLL_VIEW = 'camera_roll_view';

export default class CameraRollExample extends Component {
    constructor(props) {
        super(props)
        this.state = {
            groupTypes: 'SavedPhotos',
            sliderValue: 1,
            bigImages: true,
        }
    }

    _onSwitchValueChange = (value) => {
        this.refs[CAMERA_ROLL_VIEW].rendererChanged();
        this.setState({bigImages: value})
    }

    _onSlidervalueChange = (value) => {
        const options = CameraRoll.GroupTypesOptions;
        const index = Math.floor(value * options.length * 0.99);
        const groupTypes = options[index];
        if (groupTypes !== this.state.groupTypes) {
            this.setState({groupTypes: groupTypes})
        }
    }

    _renderImage = (asset) => {
        const imageSize = this.state.bigImages? 150 : 75
        const imageStyle = [styles.image, {width: imageSize, height: imageSize}]
        const location = asset.node.location.longitude ? JSON.stringify(asset.node.location) : 'Unknow location'

        return (
            <TouchableOpacity key={asset} onPress={this.loadAsset(asset)}>
                <View style={styles.row}>
                    <Image source={asset.node.image} style={imageStyle}/>
                    <View style={styles.info}>
                        <Text style={styles.url}>{asset.node.image.uri}</Text>
                        <Text>{location}</Text>
                        <Text>{asset.node.group_name}</Text>
                        <Text>{new Date(asset.node.timestamp).toString()}</Text>
                    </View>
                </View>
            </TouchableOpacity>
        )
    }

    loadAsset = (asset) => {
        if (this.props.navigator) {
            this.props.navigator.push({
                title: 'Camera Roll Image',
                backButtonTitle: 'Back',
                passProps: {asset: asset},
            })
        }
    }

    render() {
        return (
            <View style={{paddingTop: 64}}>
                <Switch onValueChange={this._onSwitchValueChange}
                        value={this.state.bigImages}/>
                <Text>{this.state.bigImages ? 'Big' : 'Small' + 'Images'}</Text>
                <Slider value={this.state.sliderValue}
                        onValueChange={this._onSlidervalueChange}/>
                <Text>{'Group Type: ' + this.state.groupTypes}</Text>
                <CamerarollView ref={CAMERA_ROLL_VIEW}
                                batchSize={20}
                                groupTypes={this.state.groupTypes}
                                renderImage={this._renderImage}
                />
            </View>
        );
    }
}


