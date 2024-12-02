const String datesColumns = '''
  $createdColumn,
  $updatedColumn,
  $softDeleteColumn
''';


const String updatedColumn = '''
   updated TEXT NULL
''';
const String createdColumn = '''
   created TEXT NULL
''';
const String softDeleteColumn = '''
   deleted TEXT NULL
''';

const uuidPrimaryColumn = 'uuid TEXT PRIMARY KEY';