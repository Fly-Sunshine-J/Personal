function FancyCheckbox(props) {
    var fancyClass = props.checked ? 'FancyChecked' : 'FancyUnchecked';
    return(
        <div className={fancyClass} onClick={props.onClick}>
            {props.children}
        </div>
    );
}

ReactDOM.render(
    <FancyCheckbox checked={true} onClick={console.log.bind(console)}>
        Hello, World!
    </FancyCheckbox>,
    document.getElementById('example')
)