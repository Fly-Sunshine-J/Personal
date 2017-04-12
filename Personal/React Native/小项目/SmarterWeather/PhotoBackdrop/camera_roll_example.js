import React, {
    Component,
} from 'react'
import {
    Image,
    CameraRoll,
} from 'react-native'

export default class PhotoBackdrop extends Component {
    constructor(props) {
        super(props);
        this.state = {
            photoSource: null,
        }
    }

    componentDidMount() {
        CameraRoll.getPhotos(
            {first: 5},
            (data) => {
                this.setState({
                    photoSource: {uri: data.edges[3].node.image.uri}
                })
            },
            (error) => {
                console.log(error);
            }
        )
    }

    render() {
        return (
            <Image style={{flex: 1, flexDirection: 'column'}}
                   source={this.state.photoSource}
                   resizeMode='cover'>
                {this.props.children}
            </Image>
        );
    }
}