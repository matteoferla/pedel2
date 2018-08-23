$(function() {
   // Snippet taken from: https://www.abeautifulsite.net/whipping-file-inputs-into-shape-with-bootstrap-3
  // We can attach the `fileselect` event to all file inputs on the page
  $(document).on('change', ':file', function() {
    var input = $(this),
        numFiles = input.get(0).files ? input.get(0).files.length : 1,
        label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
    input.trigger('fileselect', [numFiles, label]);
  });

  // We can watch for our custom `fileselect` event like this
  $(document).ready( function() {
      $(':file').on('fileselect', function(event, numFiles, label) {

          var input = $(this).parents('.input-group').find(':text'),
              log = numFiles > 1 ? numFiles + ' files selected' : label;

          for (var fi=0; fi < numFiles; fi++) {
              var opts='File '+(1+fi).toString()+' label: <div class="input-group"><div class="input-group-btn"><button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span id="land_type_label_drop_'+fi.toString()+'">Type </span><span class="caret"></span></button><ul class="dropdown-menu" data-n="'+fi.toString()+'"><li data-way="-" style="cursor:pointer">Unbound/Substrate</li><li data-way="+" style="cursor:pointer">Intermediate/Product</li></ul></div><!-- /btn-group --><input type="text" class="form-control" aria-label="label" data-n="'+fi.toString()+'" value="'+event.target.files[fi].name+'"></div><!-- /input-group -->';
              $('#land_file_labels').append(opts);
          }
          $('#land_file_labels li').each(function(index) {
            $(this).click(function() {
                var t=$(this).data('way');
                var n=$(this).parent().data('n');
                $('#land_type_label_drop_'+n).html(t);
                $('#land_type_label_drop_'+n).data('way',t);
                $('#land_type_label_drop_'+n).data('n',n);
            });
            });

          $('.dropdown-toggle').dropdown();

          if( input.length ) {
              input.val(log);
          } else {
              if( log ) alert(log);
          }

      });
  });
  $('#land_demo').click(function() {
    $("#land_results").show();
    $("#land_results").removeClass('hidden');
    $("#land_results").html('<div class="alert alert-info" role="alert">Calculating</div>');
    var data = new FormData();
    data.append("demo", 1);
    land_calc(data);

  });
  var heat_dataset=[]; //to be filled.. lazy scoping.

  function plot_heat(n, name) {
    var data = [
        {   x: reply['heat_data_xlabel'],
            y: reply['heat_data_ylabel'],
            z: heat_dataset[n],
            type: 'heatmap'
            }
        ];
    var layout = {title: name, yaxis: {showticklabels: true, type: 'category', dtick: 1}};
    Plotly.newPlot('land_heatmap',data,layout);
  }

  function land_calc(data) {
    try {
            $.ajax({
                url: "/ajax_land",
                type: "POST",
                data: data,
                processData: false,
                cache: false,
                contentType: false,
                success: function(result) {
                    //reply = JSON.parse(result.message);
                    reply = result;
                    //window.sessionStorage.setItem('heatmap_data',reply['heatmap_data']);
                    heat_dataset=reply['heatmap_data'];
                    $("#land_results").html(reply['html']);
                    $('#myTabs a:first').tab('show');
                    $('.dropdown-toggle').dropdown();
                    $('#land_heat_options li').on('click', function(){
                        console.log('DATA CHANGED'+$(this).data('name'));
                        plot_heat($(this).data('n'),$(this).data('name'));
                        $('#land_heat_chosen_label').html($(this).data('name'));
                    });

                    plot_heat(0,'First column');
                },
                error: function(xhr, s) {
                    $("#land_results").html('<div class="alert alert-danger" role="alert">Error — server side'+s+'</div>');
                }
            });
        } catch (err) {
            $("#land_results").html('<div class="alert alert-danger" role="alert">Error — client side<br/>'+err+'</div>');
        }
  }

  $('#land_calculate').click(function() {
        $("#land_results").show();
        $("#land_results").removeClass('hidden');
        $("#land_results").html('<div class="alert alert-info" role="alert">Calculating</div>');
        var data = new FormData();
        var files=document.getElementById('land_upload').files;
        data.append('number_of_files',files.length);
        data.append('AAlphabet',$('#land_AA_order').val());
        for (var i=0; i<files.length; i++) {
            data.append("file_"+i.toString(), files[i]);
            data.append("way_"+i.toString(), $('#land_type_label_drop_'+n).data('way'));
        }
        //data.append("your_study", $('input[name=your_study2]:checked').val());
        land_calc(data);
    });

});