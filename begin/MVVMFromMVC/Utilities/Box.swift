import Foundation

// This class perfoms "boxing" wich is a mechanism for binding together the viewcontroller
// and the viewmodel. The Box object is created in (and belongs to ) the view model. Here, the
// value is set to a default value. This value is changed later in the view controller,
// and here, a listener function is also defined which will be triggered every time the
// value is changed.


// Final means that no other class can inherit from this.
// An object of the class Box can be created like this:
// var box = Box<String>()
final class Box <T> {
  
  // typalias is just another name for a type. This means "Listener" is now a type of function,
  // and any function which takes T as argument and returns Void can be initialized with the type
  // "Listener". Generally in programming; an "event listener" is a function in a computer program that waits for an event to occur, and which is automatically executed after that event.
  typealias Listener = (T) -> Void
  
  // A new function is created of the type Listener (optional, can be nil), but it is not defined.
  // All we know so far is that listener must take T as argument and return Void.
  var listener: Listener?
  
  // The variable "value" is created of type T, and a property observer is set on the variable.
  // This means that every time the value of "value" is changed, didSet will be called.
  // Inside didSet, the function "listener" is called, with the argument value.
  var value: T {
      didSet {
        listener?(value)
      }
    }
    
  // This is the initializer for the class Box. The underscore is there to enable calling init without a label.
    init(value: T) {
      self.value = value
    }
  
  // The method bind can be called on a Box object. It takes a Listener as argument (ie a function of the type
  // Listener). It sets the attribute "listener" to the Listener function received as argument.
  // The function listener is then called with the value as argument.
    func bindListenerToValue(listener: Listener?) {
      self.listener = listener
      listener?(value)
    }
  
  
  
  
}
