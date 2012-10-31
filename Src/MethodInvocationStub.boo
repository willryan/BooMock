namespace BooMock

import System.Collections.Generic

# represents an invocation of a particular method on a mock 
# (parameters plus a sequential queue of values to return)
class MethodInvocationStub: 
	private _returnList as Queue[of object]
	private _params as (object)

	def constructor(params as (object)):
		_params = params
		_returnList = null
		
	# TODO use a getter to remove the need for ()
	def Then():
		return self
		
	def Returns(returnValue):
		if (_returnList == null):
			_returnList = Queue[of object]()
		_returnList.Enqueue(returnValue)
		return self
		
	# INTERNAL USE
	
	def matchesInvocation(params as (object)):
		if (_params == null):
			return true
		elif (_params == params):
			return true
		else:
			return false
	
	def onInvocation():
		if (_returnList != null):
			if (_returnList.Count > 1):
				return _returnList.Dequeue()
			else:
				return _returnList.Peek()
