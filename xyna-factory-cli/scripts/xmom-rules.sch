<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron">
  <ns prefix="x" uri="http://www.gip.com/xyna/xdev/xfractmod"/>
  <ns prefix="ex" uri="http://www.gip.com/xyna/3.0/utils/message/storage/1.1"/>
  <!-- XMOM Datatype and Exception Additional Rules -->
  <pattern id="TypeName-PascalCase">
    <rule context="x:DataType">
      <assert test="string-length(@TypeName) &gt; 0 and substring(@TypeName,1,1) = translate(substring(@TypeName,1,1),'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ') and not(translate(@TypeName,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',''))">
        TypeName should be PascalCase (start with uppercase, letters/numbers only).
      </assert>
    </rule>
  </pattern>
  <pattern id="Exception-TypeName-PascalCase">
    <rule context="ex:ExceptionType">
      <assert test="string-length(@TypeName) &gt; 0 and substring(@TypeName,1,1) = translate(substring(@TypeName,1,1),'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ') and not(translate(@TypeName,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',''))">
        Exception TypeName should be PascalCase (start with uppercase, letters/numbers only).
      </assert>
    </rule>
  </pattern>
  <pattern id="TypePath-JavaPackage">
    <rule context="x:DataType">
      <assert test="string-length(@TypePath) &gt; 0 and not(contains(@TypePath,'..')) and substring(@TypePath,1,1) != '.' and substring(@TypePath, string-length(@TypePath),1) != '.' and not(translate(substring(@TypePath,1,1),'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_','')) and not(translate(@TypePath,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_.',''))">
        TypePath must be a valid Java package name (dot-separated, start with letter or underscore).
      </assert>
    </rule>
  </pattern>
  <pattern id="Exception-TypePath-JavaPackage">
    <rule context="ex:ExceptionType">
      <assert test="string-length(@TypePath) &gt; 0 and not(contains(@TypePath,'..')) and substring(@TypePath,1,1) != '.' and substring(@TypePath, string-length(@TypePath),1) != '.' and not(translate(substring(@TypePath,1,1),'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_','')) and not(translate(@TypePath,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_.',''))">
        Exception TypePath must be a valid Java package name (dot-separated, start with letter or underscore).
      </assert>
    </rule>
  </pattern>
  <pattern id="Variable-CamelCase">
    <rule context="x:DataType//x:Data">
      <assert test="string-length(@VariableName) &gt; 0 and substring(@VariableName,1,1) = translate(substring(@VariableName,1,1),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz') and not(translate(@VariableName,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',''))">
        Attribute (variable) name should be CamelCase (start with lowercase, letters/numbers only).
      </assert>
    </rule>
  </pattern>
  <pattern id="Exception-Variable-CamelCase">
    <rule context="ex:ExceptionType//ex:Data">
      <assert test="string-length(@VariableName) &gt; 0 and substring(@VariableName,1,1) = translate(substring(@VariableName,1,1),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz') and not(translate(@VariableName,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',''))">
        Exception attribute (variable) name should be CamelCase (start with lowercase, letters/numbers only).
      </assert>
    </rule>
  </pattern>
  <pattern id="ReferenceName-PascalCase">
    <rule context="x:DataType//x:Data">
      <assert test="not(@ReferenceName) or (string-length(@ReferenceName) &gt; 0 and substring(@ReferenceName,1,1) = translate(substring(@ReferenceName,1,1),'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ') and not(translate(@ReferenceName,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',''))) ">
        ReferenceName must be PascalCase (start with uppercase, letters/numbers only).
      </assert>
    </rule>
  </pattern>
  <pattern id="ReferencePath-JavaPackage">
    <rule context="x:DataType//x:Data">
      <assert test="not(@ReferencePath) or (string-length(@ReferencePath) &gt; 0 and not(contains(@ReferencePath,'..')) and substring(@ReferencePath,1,1) != '.' and substring(@ReferencePath, string-length(@ReferencePath),1) != '.' and not(translate(substring(@ReferencePath,1,1),'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_','')) and not(translate(@ReferencePath,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_.','')))">
        ReferencePath must be a valid Java package name (dot-separated, start with letter or underscore).
      </assert>
    </rule>
  </pattern>
  <pattern id="Allowed-Primitive-Types">
    <rule context="x:DataType//x:Data/x:Meta/x:Type">
      <assert test="text() = 'String' or text() = 'int' or text() = 'long' or text() = 'double' or text() = 'boolean' or text() = 'Integer' or text() = 'Long' or text() = 'Double' or text() = 'Boolean' or text() = 'GeneralXynaObject'">
        Type must be String or a supported Java primitive/boxed type (or GeneralXynaObject).
      </assert>
    </rule>
  </pattern>
  <pattern id="Exception-Allowed-Primitive-Types">
    <rule context="ex:ExceptionType//ex:Data/ex:Meta/ex:Type">
      <assert test="text() = 'String' or text() = 'int' or text() = 'long' or text() = 'double' or text() = 'boolean' or text() = 'Integer' or text() = 'Long' or text() = 'Double' or text() = 'Boolean' or text() = 'GeneralXynaObject'">
        Exception type must be String or a supported Java primitive/boxed type (or GeneralXynaObject).
      </assert>
    </rule>
  </pattern>
  <pattern id="Unique-VariableNames">
    <rule context="x:DataType">
      <assert test="not(x:Data[@VariableName = following::x:Data/@VariableName])">
        VariableName must be unique across the datatype attributes.
      </assert>
    </rule>
  </pattern>
  <pattern id="Service-Input-Unique-VariableNames">
    <rule context="x:Input">
      <assert test="not(x:Data[@VariableName = following-sibling::x:Data/@VariableName])">
        Service input parameters must have unique VariableNames within the same operation input.
      </assert>
    </rule>
  </pattern>
  <pattern id="Service-Output-Unique-VariableNames">
    <rule context="x:Output">
      <assert test="not(x:Data[@VariableName = following-sibling::x:Data/@VariableName])">
        Service output parameters must have unique VariableNames within the same operation output.
      </assert>
    </rule>
  </pattern>
  <pattern id="Operation-Unique-VariableNames">
    <rule context="x:Operation">
      <assert test="not(.//x:Data[@VariableName = following::x:Data/@VariableName])">
        All variables within an operation (inputs/outputs) must have unique VariableNames.
      </assert>
    </rule>
  </pattern>
  <pattern id="Exception-Unique-VariableNames">
    <rule context="ex:ExceptionType">
      <assert test="not(.//ex:Data[@VariableName = following::ex:Data/@VariableName])">
        Exception variable names must be unique within the exception type.
      </assert>
    </rule>
  </pattern>
  <pattern id="Unique-Data-IDs">
    <rule context="x:DataType">
      <assert test="not(.//x:Data[@ID = following::x:Data/@ID])">
        All Data elements must have unique ID attributes within the datatype.
      </assert>
    </rule>
  </pattern>
  <pattern id="Exception-Unique-Data-IDs">
    <rule context="ex:ExceptionType">
      <assert test="not(.//ex:Data[@ID = following::ex:Data/@ID])">
        All Data elements must have unique ID attributes within the exception type.
      </assert>
    </rule>
  </pattern>
  <pattern id="TopLevelDataVsServiceInput-VariableNames">
    <rule context="x:DataType">
      <assert test="not(x:DataType/x:Data[@VariableName = following::x:Service//x:Input//x:Data/@VariableName])">
        Top-level Data variables may not reuse the same VariableName as service input parameters.
      </assert>
    </rule>
  </pattern>
</schema>
