extends Resource
class_name Deck

const DEFAULT_DECK : Resource = preload("res://scripts/decks/DefaultDeck.tres")

@export var name: String = "Default Deck"
@export_multiline var description: String = "This is the default MC Wizards deck. Try it out in a match!"
@export var spells: Array[Spell] = []

@export var max_size := 15

var size = len(spells)
var full := false

## Adds an element to the array.
## - spell (Spell) : Spell to add to the deck
func add_spell(spell:Spell) -> Error:
	# Check if deck is not full
	if full:
		print("Deck " + self.name + " is full, cannot add spell " + spell.id)
		return ERR_UNAUTHORIZED
	# Add spell
	spells.append(spell)
	# Update size of deck
	size += 1
	# Sort deck
	var sort_err = self.sort()
	if sort_err != OK :
		return sort_err

	print("Spell " + spell.name + " added to deck "+ self.name)
	return OK

## Sorts deck by mana cost, then name
func sort() -> Error :
	var new_spells : Array[Spell] = [spells[0]]
	var diff := 0
	var found : bool = false
	for i in range(1,len(spells)) :
		## Sorting logic
		for j in range(len(new_spells)) :
			found = false
			if new_spells[j].cost == spells[i].cost :
				# -1 if new_spell under spell, 0 if new_spell next to spell, 1 if new_spell above spell.
				diff = spells[i].id.casecmp_to(new_spells[j].id)
				if diff == 0 or diff == 1 :
					new_spells.insert(j, spells[i])
					found = true
			elif new_spells[j].cost > spells[i].cost:
				new_spells.insert(j, spells[i])
				found = true
		if not found :
			new_spells.append(spells[i])

	return OK

## Parses Deck to Dictionnary
func to_dict() -> Dictionary :
	return {
		"name" : name,
		"description" : description,
		"max_size" : max_size,
		"spells" : spells.map(func(element:Spell):return element.id)
	}
	
## Parses Dictionnary to Deck
static func from_dict(dict : Dictionary) -> Deck :
	var deck : Deck = Deck.new()
	deck.name = dict["name"] if "name" in dict.keys() else "Unnamed Deck"
	deck.description = dict["description"] if "description" in dict.keys() else "No description."
	deck.max_size = dict["max_size"] if "max_size" in dict.keys() else 15
	deck.spells = ((dict["spells"] as Array[String]).map(func(el):return Spell.from_id(el))) if "spells" in dict.keys() else []
	return deck
