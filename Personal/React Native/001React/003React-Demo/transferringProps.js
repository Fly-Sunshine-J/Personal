class CheckLink extends React.Component {
    render(){
        return(
            <a {...this.props}>{'√ '}{this.props.children}</a>
        )
    }
}

ReactDOM.render(
    <CheckLink href={'https://www.baidu.com'}>
        Click Here!
    </CheckLink>,
    document.getElementById('example')
);