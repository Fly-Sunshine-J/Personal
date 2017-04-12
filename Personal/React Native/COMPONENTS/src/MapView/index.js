import React, { Component, PropTypes } from 'react'
import {
    MapView,
    View,
    TouchableOpacity,
    Text,
    TextInput,
    Image,
    StyleSheet,
    ScrollView,
} from 'react-native'

var regionText = {
    lat: '0',
    lon: '0',
    latDelta: '0',
    longDelta: '0',
}

class MapRegionInput extends Component {
    static propTypes = {
        region: React.PropTypes.shape({
            latitude: React.PropTypes.number.isRequired,
            longitude: React.PropTypes.number.isRequired,
            latitudeDelta: React.PropTypes.number,
            longitudeDelta: React.PropTypes.number,
        }),
        onChange: React.PropTypes.func.isRequired,
    }

    constructor(props) {
        super(props);
        this.state = {
            region: {
                latitude: 0,
                longitude: 0,
                latitudeDelta: 0,
                longitudeDelta: 0,
            }
        }
    }

    componentWillReceiveProps(nextProps) {
        this.setState({
            region: {
                latitude: nextProps.region.latitude,
                longitude: nextProps.region.longitude,
                latitudeDelta: nextProps.region.latitudeDelta,
                longitudeDelta: nextProps.region.longitudeDelta,
            }
        })
}

    _onChangeLat(event) {
        regionText.lat = event.nativeEvent.text;
    }

    _onChangeLon(event) {
        regionText.lon = event.nativeEvent.text;
    }

    _onChangeLatDelta(event) {
        regionText.latDelta = event.nativeEvent.text;
    }

    _onChangeLonDelta(event) {
        regionText.longDelta = event.nativeEvent.text;
    }

    _change() {
        this.setState({
            region: {
                latitude: parseFloat(regionText.lat),
                longitude: parseFloat(regionText.lon),
                latitudeDelta: parseFloat(regionText.latDelta),
                longitudeDelta:parseFloat(regionText.longDelta),
            }
        })
        this.props.onChange({
            latitude: parseFloat(regionText.lat),
            longitude: parseFloat(regionText.lon),
            latitudeDelta: parseFloat(regionText.latDelta),
            longitudeDelta:parseFloat(regionText.longDelta),
        })

    }

    render() {
        var region = this.state.region || {region: {
                latitude: 0,
                longitude: 0,
            }};
        return (
            <View>
                <View style={styles.row}>
                    <Text>{'Latitude: '}</Text>
                    <TextInput placeholder={String(region.latitude)}
                               style={styles.textInput}
                               onChange={(event) => this._onChangeLat(event)}
                               selectTextOnFocus={true} />
                </View>
                <View style={styles.row}>
                    <Text>{'Longitude: '}</Text>
                    <TextInput placeholder={String(region.latitude)}
                               style={styles.textInput}
                               onChange={(event) => this._onChangeLon(event)}
                               selectTextOnFocus={true} />
                </View>
                <View style={styles.row}>
                    <Text>{'Longitude delta: '}</Text>
                    <TextInput placeholder={region.latitudeDelta == null ? '' : String(region.latitudeDelta)}
                               style={styles.textInput}
                               onChange={(event) => this._onChangeLatDelta(event)}
                               selectTextOnFocus={true} />
                </View>
                <View style={styles.row}>
                    <Text>{'Longitude delta: '}</Text>
                    <TextInput placeholder={region.longitudeDelta == null ? '' : String(region.longitudeDelta)}
                               style={styles.textInput}
                               onChange={(event) => this._onChangeLonDelta(event)}
                               selectTextOnFocus={true} />
                </View>
                <View style={styles.button}>
                    <Text onPress={() => this._change()}>Change</Text>
                </View>
            </View>
        );
    }


}


class AnnotationExample extends Component {
    constructor(props) {
        super(props);
        this.state = {
            isFirstLoad: true,
            annotations: [],
            mapRegion: undefined,
        }
    }

    render() {
        if (this.state.isFirstLoad) {
            var onRegionChangedComplete = (region) => {
                this.setState({
                    isFirstLoad: false,
                    annotations: [{
                        longitude: region.longitude,
                        latitude: region.latitude,
                        ...this.props.annotation,
                    }],
                    mapRegion: region,
                })
            }
        }
        return (
            <MapView style={[styles.map, {marginTop: 20}]}
                     onRegionChangeComplete={onRegionChangedComplete}
                     region={this.state.mapRegion}
                     annotations={this.state.annotations}
            />
        );
    }
}


class DraggableAnnotationExample extends Component {
    constructor(props) {
        super(props);
        this.state = {
            isFirstLoad: true,
            annotations: [],
            mapRegion: undefined,
        }
    }

    createAnnotation = (longitude, latitude) => {
        return {
            longitude,
            latitude,
            draggable: true,
            onDragStateChange: (event) => {
                if(event.state === 'idle') {
                    this.setState({
                        annotations: [this.createAnnotation(event.longitude, event.latitude)],
                    });
                }
                console.log('Drag state: ' + event.state);
            }
        }
    }

    render() {
        if(this.state.isFirstLoad) {
            var onRegionChangeComplete = (region) => {
                this.setState({
                    isFirstLoad: false,
                    annotations: [this.createAnnotation(region.longitude, region.latitude)],
                })
            }
        }
        return (
            <MapView style={styles.map}
                     onRegionChangeComplete={onRegionChangeComplete}
                     region={this.state.region}
                     annotations={this.state.annotations}
            />
        )
    }
}





export default class MapViewExample extends Component {

    constructor(props) {
        super(props);
        this.state = {
            isFirstLoad: true,
            mapRegion: undefined,
            mapRegionInput: undefined,
            annotations: [],
        }
    }

    _getAnnotations(region) {
        return [
            {
                latitude: region.latitude,
                longitude: region.longitude,
                title: 'You Are Here',
            }
        ]
    }

    _regionChanged(region) {
        this.setState({
            mapRegionInput: region,
            mapRegion: region,
            annotations: this._getAnnotations(region)
        })
    }

    _onRegionChange(region) {
        this.setState({
            mapRegionInput: region,
        })
    }

    _onRegionChangeComplete(region) {
        if(this.state.isFirstLoad) {
            this.setState({
                isFirstLoad: false,
                mapRegionInput: region,
                annotations: this._getAnnotations(region),
            })
        }
    }

    render() {
        return (
            <ScrollView>
                <MapView style={styles.map}
                         onRegionChange={(region) => this._onRegionChange(region)}
                         onRegionChangeComplete={(region) => this._onRegionChangeComplete(region)}
                         region={this.state.mapRegion}
                         annotations={this.state.annotations}
                />
                <MapRegionInput onChange={(region) =>this._regionChanged(region)}
                                region={this.state.mapRegionInput}
                />
                <Text>定位</Text>
                <MapView style={styles.map}
                         showsUserLocation={true}
                         followUserLocation={true}
                />
                <Text>Callout Example:</Text>
                <AnnotationExample annotation={{
                    title: 'More Info...',
                    rightCalloutView: (
                        <TouchableOpacity
                            onPress={() => {
                                alert('You Are Here');
                            }}>
                            <Image
                                style={{width:30, height:30}}
                                source={require('../../images/circular.png')}
                            />
                        </TouchableOpacity>
                    ),
                }}/>
                <Text>Annotation focus Example:</Text>
                <AnnotationExample annotation={{title: 'More Info...',
                    onFocus: () => {
                        alert('Annotation get focus');
                    },
                    onBlur: () => {
                        alert('Annotation lost focus');
                    }
                }}/>
                <Text>拖拽大头针:</Text>
                <DraggableAnnotationExample />
                <Text>自定义大头针颜色:</Text>
                <AnnotationExample annotation={{
                    title: 'You Are Purple',
                    tintColor: MapView.PinColors.PURPLE,
                }}/>
                <Text>自定义大头针图片</Text>
                <AnnotationExample annotation={{
                    title: 'Thumbs Up!',
                    image: require('../../images/car.png')
                }}/>
                <Text>自定义大头针视图</Text>
                <AnnotationExample annotation={{
                    title: 'Thumbs Up!',
                    view:
                        <View style={{alignItems: 'center'}}>
                            <Text style={{fontWeight: 'bold', color: '#f007'}}>Thumbs Up!</Text>
                            <Image style={{width: 40, height: 40, resizeMode: 'cover'}}
                                   source={require('../../images/car.png')}
                            />
                        </View>
                }}/>
                <Text>自定义覆盖物</Text>
                <MapView style={styles.map}
                         region={{latitude: 39.06, longitude: 117}}
                         overlays={[
                             {
                                 coordinates:[
                                     {latitude: 37, longitude: 115},
                                     {latitude: 41, longitude: 115},
                                     {latitude: 41, longitude: 119},
                                     {latitude: 37, longitude: 119},
                                     {latitude: 37, longitude: 115},
                                 ],
                                 strokeColor: '#f007',
                                 lineWidth: 2,
                             }
                         ]}
                />
            </ScrollView>
        );
    }
}







const styles = StyleSheet.create({
    map: {
        height: 150,
        margin: 10,
        borderWidth: 1,
        borderColor: 'black',
    },
    row: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        marginLeft: 10,
        marginRight: 10,
    },
    textInput: {
        width: 150,
        height: 20,
        borderWidth: 0.5,
        borderColor: '#aaaaaa',
        fontSize: 13,
        padding: 4,
    },
    button: {
        alignSelf: 'center',
        borderWidth: 1,
        borderColor: 'blue',
        marginTop: 5,
    }
})