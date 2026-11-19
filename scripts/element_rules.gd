# element_rules.gd — spell resolver, demo set (5 classical elements)
class_name ElementRules
enum E { METAL, WOOD, WATER, FIRE, EARTH }

# unordered counter pair -> byproduct
const COUNTER := {
	"0_1": "broken_branch",  # metal-wood
	"0_3": "molten_metal",   # metal-fire
	"1_4": "cracked_earth",  # wood-earth
	"2_3": "steam",          # water-fire
	"2_4": "mud",            # water-earth
}
# generation: wood>fire>earth>metal>water>wood
const GENERATE := [[1, 3], [3, 4], [4, 0], [0, 2], [2, 1]]

static func key(a: int, b: int) -> String:
	return "%d_%d" % [mini(a, b), maxi(a, b)]

static func resolve(slots: Array) -> Dictionary:
	var s := slots.duplicate()
	var byproduct := ""
	var i := 0
	while i < s.size() - 1:
		var k := key(s[i], s[i + 1])
		if COUNTER.has(k):
			byproduct = COUNTER[k]  # latest wins
			s.remove_at(i + 1)
			s.remove_at(i)
			i = maxi(i - 1, 0)  # re-check new neighbours
		else:
			i += 1
	var mult := 1.0
	for j in range(s.size() - 1):
		if s[j] == s[j + 1]:
			mult += 0.25
		elif [s[j], s[j + 1]] in GENERATE:
			mult += 0.3
	return {
		"shape": s[0] if s.size() > 0 else -1,
		"statuses": s.slice(1),
		"mult": minf(mult, 2.0),
		"byproduct": byproduct,
	}
