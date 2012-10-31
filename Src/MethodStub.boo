namespace BooMock
# Represents calls to a particular function for a mock
class MethodStub: 
	private _methodName as string
	private _invocations as List
	private _genericInvocation as MethodInvocationStub

	def constructor(methodName as string):
		_methodName = methodName
		_invocations = []
		
	def With(*params) as MethodInvocationStub:
		invocation = findSpecificInvocation(params)
		if (invocation == null):
			invocation = MethodInvocationStub(params)
			_invocations.Add(invocation)
		return invocation
		
	def Returns(returnValue):
		_genericInvocation = MethodInvocationStub(null)
		_genericInvocation.Returns(returnValue)
		return _genericInvocation
	
	# INTERNAL USE
	
	def findSpecificInvocation(params as (object)) as MethodInvocationStub:
		return _invocations.Find() do (inv as MethodInvocationStub):
			return inv.matchesInvocation(params)

	def findInvocation(params as (object)) as MethodInvocationStub:
		return (findSpecificInvocation(params) or _genericInvocation)
		
