# Represents calls to a particular function for a mock
class BooMethodStub: 
	private _methodName as string
	private _invocations as List
	private _genericInvocation as BooMethodInvocationStub

	def constructor(methodName as string):
		_methodName = methodName
		_invocations = []
		
	def With(*params) as BooMethodInvocationStub:
		invocation = findSpecificInvocation(params)
		if (invocation == null):
			invocation = BooMethodInvocationStub(params)
			_invocations.Add(invocation)
		return invocation
		
	def Returns(returnValue):
		_genericInvocation = BooMethodInvocationStub(null)
		_genericInvocation.Returns(returnValue)
		return _genericInvocation
	
	# INTERNAL USE
	
	def findSpecificInvocation(params as (object)) as BooMethodInvocationStub:
		return _invocations.Find() do (inv as BooMethodInvocationStub):
			return inv.matchesInvocation(params)

	def findInvocation(params as (object)) as BooMethodInvocationStub:
		return (findSpecificInvocation(params) or _genericInvocation)
		