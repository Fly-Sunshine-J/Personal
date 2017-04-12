import React, {Component} from 'react'
import {
    View,
    Text,
    SliderIOS,
    Slider,
    ScrollView,
} from 'react-native'


class Page extends Component {
    static propTypes = {
        title: React.PropTypes.string,
    }

    constructor(props) {
        super(props);
        this.state = {
            value: this.props.value,

        }
    }

    _onValueChange(value) {
        this.setState({
            value:value,
        })
    }

    render() {
        var {children, ...other} = this.props
        return (
            <View style={{margin: 10, backgroundColor: 'white'}}>
                <View style={{height: 20, backgroundColor: 'rgb(244, 245, 248)'}}>
                    <Text>{this.props.title}</Text>
                </View>
                <Text style={{textAlign: 'center'}}>{this.state.value}</Text>
                <View style={{height: 50}}>
                    <Slider value={this.state.value} onValueChange={(value) => {this._onValueChange(value)}} {...other} />
                    {children}
                </View>
            </View>
        );
    }
}

export default class SliderExample extends Component {

    constructor(props){
        super(props);
        this.state = {
            completeCount: 0,
            value: 0,
        }

    }

    _onSlidingComplete(value) {
        this.setState({
            completeCount: this.state.completeCount + 1,
            value: value,
        })
    }


    render() {
        return (
            <ScrollView style={{backgroundColor: 'rgb(228, 229, 234)'}}>
                <Page title='Default settings' value={0}/>
                <Page title='initial value: 0.5' value={0.5}/>
                <Page title='min: -1, max: 2' value={0} minimumValue={-1} maximumValue={2}/>
                <Page title='step: 0.25' value={0} step={0.25}/>
                <Page title='onSlidingComplete' value={0} onSlidingComplete={(value) => {this._onSlidingComplete(value)}}>
                    <Text>CompleteCount: {this.state.completeCount} Value: {this.state.value}</Text>
                </Page>
                <Page title='Custom min/max track tint color (ios only)' value={0} maximumTrackTintColor="red" minimumTrackTintColor="green"/>
                <Page title='Cuntom thumb image (ios only)' value={0} thumbImage={require('../../images/dot.png')}/>
                <Page title='Custom track image (ios only)' value={0} trackImage={require('../../images/dot.png')}/>
                <Page title='Custom min/max track image (ios only)' value={0} minimumTrackImage={require('../../images/dot.png')} maximumTrackImage={require('../../images/dot_blue.png')}/>
            </ScrollView>
        );
    }

}