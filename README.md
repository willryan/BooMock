BooMock
=======

Mocking library for the Boo language (compatible with Unity Engine).  Modelled after Mocha.

Usage
=====

namespace BooMock

mock = Mock("mock name for reference")
mock.Stubs("FunctionName").With("argument", "list").Returns("return value")

mock.FunctionName("argument", "list") == "return value"

The argument matching looks for exact matches.  Parameter matchers / closures 
will be coming in a future release.  However, you can omit the With call
to match any arguments.  More specific Stubs will be honored before this 
generic Return.

mock.Stubs("FunctionName").Returns("different value")

mock.FunctionName("whatever") == "different value")

You can chain Returns calls (with Then() if you want) to indicate subsequent
returns. More generic functionality like Times(#) to come in a later release.

mock.Stubs("FunctionName").With(1).Returns(3).Then().Returns(5)

mock.FunctionName(1) == 3
mock.FunctionName(1) == 5
