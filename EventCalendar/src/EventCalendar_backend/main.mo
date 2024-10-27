import Buffer "mo:base/Buffer";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Time "mo:base/Time";

actor {
  type EventId = Nat;
  
  type Event = {
    id: EventId;
    name: Text;
    date: Time.Time;
    location: Text;
    reminder: Bool;
  };

  var events = Buffer.Buffer<Event>(0);

  public func createEvent(name: Text, date: Time.Time, location: Text, reminder: Bool) : async EventId {
    let eventId = events.size();
    let newEvent: Event = {
      id = eventId;
      name = name;
      date = date;
      location = location;
      reminder = reminder;
    };
    events.add(newEvent);
    eventId
  };

  public query func getEvent(eventId: EventId) : async ?Event {
    if (eventId < events.size()) {
      ?events.get(eventId);
    } else {
      null;
    };
  };

  public query func getAllEvents() : async [Event] {
    Buffer.toArray(events)
  };

  public func updateReminder(eventId: EventId, reminder: Bool) : async Bool {
    if (eventId >= events.size()) return false;
    let event = events.get(eventId);
    let updatedEvent: Event = {
      id = event.id;
      name = event.name;
      date = event.date;
      location = event.location;
      reminder = reminder;
    };
    events.put(eventId, updatedEvent);
    true
  };
}