You have exaclty the following Xyna formula language functions available in Xyna workflows:
You MUST uae only these functions or functions of datatypes in Xyna formulas.
**Do not** invent new Xyna formula language functions.

Xyna datatype lists:

- append(<Xyna datatype list>, <Xyna datatype>) : <Xyna datatype list>
- concatlists(<Xyna datatype list>, <Xyna datatype list>) : <Xyna datatype list>
- length(<Xyna datatype list>) : int, >= 0

Predicates on Strings:
- contains(<content string>, <search string>) : boolean
- startsWith(<content string>, <search string>) : boolean
- endWith(<content string>, <search string>) : boolean
- matches(<content string>, <regexp string>) : boolean

String functions:
- indexOf(<content string>, <search string>) : int, >= -1
- length(<string>) : int, >= 0

String manipulations:
- toLowerCase(<string>) : String
- toUpperCase(<string>) : String
- concat(<string 1> , <string 2> [, <string 3..n>]) : String
- substring(<string> , <start index, inclusive, 0 based>, <end index, exclusive>) : String
- replaceAll(<content string>, <regexp string>, <replace string>) : String

"instance of" for Xyna datatypes:
- typeOf(<Xyna datatype>, <Xyna datatype fqn string>) : booolean

Important!:
- You are working with Strings in XML!
- Use propper XML escaping.
- RegExp are Java RegExp i.e. use double slashes.