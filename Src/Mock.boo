namespace BooMock

# BooMock - uses IQuackFu duck typing to mock method calls
# Use it as follows:
#
# mock = Mock("mock name for reference")
# mock.Stubs("FunctionName").With("argument", "list").Returns("return value")
#
# mock.FunctionName("argument", "list") == "return value"
#
# The argument matching looks for exact matches.  Parameter matchers / closures 
# will be coming in a future release.  However, you can omit the With call
# to match any arguments.  More specific Stubs will be honored before this 
# generic Return.
#
# mock.Stubs("FunctionName").Returns("different value")
#
# mock.FunctionName("whatever") == "different value")
#
# You can chain Returns calls (with Then() if you want) to indicate subsequent
# returns. More generic functionality like Times(#) to come in a later release.
#
# mock.Stubs("FunctionName").With(1).Returns(3).Then().Returns(5)
#
# mock.FunctionName(1) == 3
# mock.FunctionName(1) == 5
#
class Mock (IQuackFu): 
	private _mockName as string
	private _methodStubs as Hash

	def constructor(name as string):
		_mockName = name
		_methodStubs = {}

	def Name():
		return _mockName

	def ToString():
		return "Mock<$(_mockName)>"
		
	def Stubs(method as string) as MethodStub:
		methodStub = _methodStubs[method]
		if (methodStub == null):
			methodStub = MethodStub(method)
			_methodStubs[method] = methodStub
		return methodStub
		
	# INTERNAL USE
	
	#TODO - more help when things don't match
	def QuackInvoke(name as string, params as (object)) as object:
		methodStub = _methodStubs[name] as MethodStub
		invocation = methodStub.findInvocation(params)
		if (invocation != null):
			return invocation.onInvocation()
		else:
			raise "$(_mockName) invocation $(name) did not match stub"
			
	// TODO support getters and setters
	def QuackGet(name as string, params as (object)) as object:
		pass
		
	def QuackSet(name as string, params as (object), obj) as object:
		pass
		
