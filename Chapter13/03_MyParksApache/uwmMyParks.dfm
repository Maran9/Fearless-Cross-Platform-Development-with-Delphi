object wmMyParks: TwmMyParks
  OldCreateOrder = False
  OnCreate = WebModuleCreate
  OnDestroy = WebModuleDestroy
  Actions = <
    item
      Default = True
      Name = 'waiAbout'
      PathInfo = '/about'
      Producer = ppAbout
    end
    item
      Name = 'waiGetParkFromQuery'
      PathInfo = '/getpark'
      Producer = ppGetParkQuery
    end
    item
      Name = 'waiShowParkFromCoords'
      PathInfo = '/showpark'
      OnAction = wmMyParkswaiShowParkFromCoordsAction
    end
    item
      Name = 'waiParkList'
      PathInfo = '/parklist'
      Producer = dstpMyParks
    end>
  Height = 347
  Width = 415
  object ppAbout: TPageProducer
    HTMLDoc.Strings = (
      '<#header PageTitle="About">'
      ''
      '<#menu>'
      ''
      
        '    <div class="col-md-12 bg-light shadow p-3 mb-5 bg-body round' +
        'ed">'
      ''
      
        '<p>The <strong><#AppName></strong> app is a simple database of p' +
        'arks, pictures of parks, and coordinates.'
      
        'You build this database yourself and use as reference for places' +
        ' you'#39've visited.</p>'
      
        '<p>Built from the book, <em>Fearless Cross-Platform Development ' +
        'with Delphi</em> by Packt Publishing.</p>'
      ''
      '    </div>'
      ''
      '<#footer>')
    OnHTMLTag = ppStandardHTMLTag
    Left = 56
    Top = 56
  end
  object ppGetParkQuery: TPageProducer
    HTMLDoc.Strings = (
      '<#header PageTitle="Park Query">'
      ''
      '<#menu>'
      ''
      
        '    <div class="col-md-12 bg-light shadow p-3 mb-5 bg-body round' +
        'ed">'
      ''
      '<h3>Find a Park by Location</h3>'
      '<form action="<#ScriptName>/showpark">'
      '  <label for="long">Longitude:</label><br>'
      '  <input type="text" id="long" name="long"><br><br>'
      '  <label for="lat">Latitude:</label><br>'
      '  <input type="text" id="lat" name="lat"><br><br>'
      '  <button type="submit" class="btn btn-primary">Submit</button>'
      '</form>'
      ''
      '    </div>'
      ''
      '<#footer>')
    OnHTMLTag = ppStandardHTMLTag
    Left = 56
    Top = 120
  end
  object ppShowParkFromCoords: TPageProducer
    HTMLDoc.Strings = (
      '<#header PageTitle="Located Park">'
      ''
      '<#menu>'
      ''
      '    <div class="col-md-12 shadow p-3 mb-5 bg-body rounded">'
      ''
      'The park at <#longitude>, <#latitude> is: <#ParkName>'
      ''
      '    </div>'
      ''
      '<#footer>')
    OnHTMLTag = ppShowParkFromCoordsHTMLTag
    Left = 72
    Top = 168
  end
  object ppPageHeader: TPageProducer
    HTMLDoc.Strings = (
      '<html>'
      '<head>'
      '<title><#AppName> | <#PageTitle></title>'
      
        '<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/cs' +
        's/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2' +
        'eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crosso' +
        'rigin="anonymous">'
      '</head>'
      '<body>'
      ''
      '<div class="container-fluid px-5">'
      '  <div class="row">'
      '    <div class="col-md-12">'
      '      <h2 class="text-center">'
      '        <#AppName>'
      '      </h2>'
      '    </div>')
    OnHTMLTag = ppPageHeaderHTMLTag
    Left = 200
    Top = 24
  end
  object ppPageFooter: TPageProducer
    HTMLDoc.Strings = (
      '  </div>'
      '</div>'
      ''
      
        '<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/j' +
        's/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNU' +
        'aaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anon' +
        'ymous"></script>'
      '</body>'
      '</html>')
    OnHTMLTag = ppPageFooterHTMLTag
    Left = 200
    Top = 80
  end
  object ppMenu: TPageProducer
    HTMLDoc.Strings = (
      '<ul class="nav nav-pills px-5 shadow p-3 mb-5 bg-body rounded">'
      '  <li class="nav-item">'
      '    <a class="nav-link" href="about">About this site</a>'
      '  </li>'
      '  <li class="nav-item">'
      
        '    <a class="nav-link" href="getpark">Get Park by Coordinates</' +
        'a>'
      '  </li>'
      '  <li class="nav-item">'
      '    <a class="nav-link" href="parklist">Show All Parks</a>'
      '  </li>'
      '</ul>')
    Left = 200
    Top = 136
  end
  object ppParkList: TPageProducer
    HTMLDoc.Strings = (
      '<#header PageTitle="Park List">'
      ''
      '<#menu>'
      ''
      '    <div class="col-md-12 shadow p-3 mb-5 bg-body rounded">'
      '<#parklist>'
      '    </div>'
      ''
      '<#footer>')
    OnHTMLTag = ppStandardHTMLTag
    Left = 56
    Top = 224
  end
  object dstpMyParks: TDataSetTableProducer
    Columns = <
      item
        FieldName = 'PARK_NAME'
      end
      item
        FieldName = 'LONGITUDE'
      end
      item
        FieldName = 'LATITUDE'
      end>
    MaxRows = 200
    DataSet = dmParksDB.qryParkList
    TableAttributes.Align = haCenter
    TableAttributes.BgColor = 'Lime'
    TableAttributes.Border = 1
    TableAttributes.CellSpacing = 2
    TableAttributes.CellPadding = 10
    TableAttributes.Width = -1
    Left = 128
    Top = 240
  end
end
