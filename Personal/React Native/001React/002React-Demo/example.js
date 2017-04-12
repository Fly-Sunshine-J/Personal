

class ProductCategoryRow extends React.Component{
    render(){
        return (<tr><th colSpan="2">{this.props.category}</th></tr>);
    }
}

class ProductRow extends React.Component{
    render(){
        var name = this.props.product.stocked ?
            this.props.product.name :
        <span style={{color: 'red'}}>
            {this.props.product.name}
        </span>;
        return(
            <tr>
                <td>{name}</td>
                <td>{this.props.product.price}</td>
            </tr>
        );
    }
}

class ProductTable extends React.Component{
    render(){
        var rows = [];
        var lastCategory = null;
        this.props.products.forEach(function (product) {
            if (product.name.indexOf(this.props.filterText) === -1 || (!product.stocked && this.props.inStockOnly)){
                return;
            }

            if (product.category != lastCategory) {
                rows.push(<ProductCategoryRow category={product.category} key={product.category}/>);
            }
            rows.push(<ProductRow product={product} key={product.name}/>);
            lastCategory = product.category;
        }.bind(this));
        return(
            <table>
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Price</th>
                    </tr>
                </thead>
                <tbody>{rows}</tbody>
            </table>
        );
    }
}

class SearchBar extends React.Component{

    handleChange(){
        this.props.onUserInput(
            this.refs.filterTextInput.value,
            this.refs.inStockOnlyInput.checked,
        );
    }
    render(){
        return(
            <form>
                <input type="text" placeholder="Search..."
                       value={this.props.filterText}
                       onChange={()=>this.handleChange()}
                       ref="filterTextInput"
                />
                <p>
                    <input type="checkbox"
                           checked={this.props.inStockOnly}
                           ref="inStockOnlyInput"
                           onChange={this.handleChange.bind(this)}
                    />
                    {' '}
                    Only show products in stock
                </p>
            </form>
        )
    }
}

class FilterableProductTable extends React.Component{
    constructor(props){
        super(props);
        this.state = {
            filterText: '',
            inStockOnly: false
        }
    }
    handleUserInput(filterText, inStockOnly) {
        this.setState({
            filterText: filterText,
            inStockOnly: inStockOnly
        });
    }
    render(){
        return(
            <div>
                <SearchBar filterText={this.state.filterText}
                           inStockOnly={this.state.inStockOnly}
                           onUserInput={this.handleUserInput.bind(this)}
                />
                <ProductTable products={this.props.products}
                              filterText={this.state.filterText}
                              inStockOnly={this.state.inStockOnly}
                />
            </div>
        )
    }

}


var products = [
    {category: "Sporting Goods", price: "$49.99", stocked: true, name: "Football"},
    {category: "Sporting Goods", price: "$9.99", stocked: true, name: "Baseball"},
    {category: "Sporting Goods", price: "$29.99", stocked: false, name: "Basketball"},
    {category: "Electronics", price: "$99.99", stocked: true, name: "iPod Touch"},
    {category: "Electronics", price: "$399.99", stocked: false, name: "iPhone 5"},
    {category: "Electronics", price: "$199.99", stocked: true, name: "Nexus 7"}
];

ReactDOM.render(
    <FilterableProductTable products={products}/>,
    document.getElementById('example')
)