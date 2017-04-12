function FancyCheckBox(props) {
    var {checked, ...other} = props;
    var FancyClass = checked ? 'FancyChecked' : 'FancyUnchecked';
    return(
        <div {...other} className={FancyClass}>

        </div>
    );

}

ReactDOM.render(
    <FancyCheckBox checked={true} onClick={console.log.bind(console)}>
        Hello world!
    </FancyCheckBox>,
    document.getElementById('example')
);