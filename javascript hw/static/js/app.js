var tableData = data;

var tbody = d3.select("tbody");

var inputDate = d3.select("datetime");

function buildTable(data) {
  tbody.html("");

  data.forEach((dataRow) => {
    var row = tbody.append("tr");

    Object.values(dataRow).forEach((val) => {
      var cell = row.append("td");
        cell.text(val);
      }
    );
  });
}

function handleClick() {
    d3.event.preventDefault();

    var inputValue = inputDate.property("value");
    let filteredData = tableData  

    if (inputValue) {
    var filterdata = tableData.filter(onerec => onerec.datetime === inputValue);}
    console.log('Filtering Data');
    console.log(filterdata);
   
    buildTable(filteredData);
}
d3.selectAll("#filter-btn").on("click", handleClick);

buildTable(tableData);

