function buildMetadata(sample) {
  d3.json(`/metadata/${sample}`).then((data) => {
    var PANEL = d3.select("#sample-metadata");
    PANEL.html("");

    Object.entries(data).forEach(([key, value]) => {
      PANEL.append("h6").text(`${key}: ${value}`);
    });

    buildGauge(data.WFREQ);
  });
}

function buildCharts(sample) {
  d3.json(`/samples/${sample}`).then((data) => {
    var x_value = response["otu_ids"];
    var y_value = response["sample_values"];
    var size_value = response["sample_values"];
    var label = response["otu_labels"];
    
    var trace1 = {
      x: x_value,
      y: y_value,
      mode:"markers", 
      marker:{
        size: size_value,
        color: x_value,
        colorscale: "Earth",
        labels: label,
        type: 'scatter',
      }
    };

    var layout = {
      title: 'Marker Size',
      xaxis: { title: 'OTU ID' },
      showlegend: true
    };
    Plotly.newPlot("bubble", trace1, layout); 

    var data = [{
      values: size_value.splice(0, 10),
      labels: x_value.splice(0, 10),
      text: y_value.splice(0,10),
      hoverinfo: "hovertext",
      type: 'pie'
    }];
    Plotly.newPlot('pie', data);
  });
}

function init() {
  // Grab a reference to the dropdown select element
  var selector = d3.select("#selDataset");

  // Use the list of sample names to populate the select options
  d3.json("/names").then((sampleNames) => {
    sampleNames.forEach((sample) => {
      selector
        .append("option")
        .text(sample)
        .property("value", sample);
    });

    // Use the first sample from the list to build the initial plots
    const firstSample = sampleNames[0];
    buildCharts(firstSample);
    buildMetadata(firstSample);
  });
}

function optionChanged(newSample) {
  // Fetch new data each time a new sample is selected
  buildCharts(newSample);
  buildMetadata(newSample);
}

// Initialize the dashboard
init();
