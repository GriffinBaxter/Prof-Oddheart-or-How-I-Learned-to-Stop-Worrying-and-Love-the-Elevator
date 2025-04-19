extends Node

const ONE_PERSON_1 = preload("res://Sounds/People/one_person_1.mp3")
const ONE_PERSON_2 = preload("res://Sounds/People/one_person_2.mp3")
const ONE_PERSON_3 = preload("res://Sounds/People/one_person_3.mp3")
const ONE_PERSON_4 = preload("res://Sounds/People/one_person_4.mp3")
const ONE_PERSON_5 = preload("res://Sounds/People/one_person_5.mp3")
const ONE_PERSON_6 = preload("res://Sounds/People/one_person_6.mp3")

const TWO_PERSON_1_1 = preload("res://Sounds/People/two_person_1_1.mp3")
const TWO_PERSON_1_2 = preload("res://Sounds/People/two_person_1_2.mp3")
const TWO_PERSON_2_1 = preload("res://Sounds/People/two_person_2_1.mp3")
const TWO_PERSON_2_2 = preload("res://Sounds/People/two_person_2_2.mp3")
const TWO_PERSON_3_1 = preload("res://Sounds/People/two_person_3_1.mp3")
const TWO_PERSON_3_2 = preload("res://Sounds/People/two_person_3_2.mp3")
const TWO_PERSON_4_1 = preload("res://Sounds/People/two_person_4_1.mp3")
const TWO_PERSON_4_2 = preload("res://Sounds/People/two_person_4_2.mp3")
const TWO_PERSON_5_1 = preload("res://Sounds/People/two_person_5_1.mp3")
const TWO_PERSON_5_2 = preload("res://Sounds/People/two_person_5_2.mp3")
const TWO_PERSON_6_1 = preload("res://Sounds/People/two_person_6_1.mp3")
const TWO_PERSON_6_2 = preload("res://Sounds/People/two_person_6_2.mp3")

const THREE_PERSON_1_1 = preload("res://Sounds/People/three_person_1_1.mp3")
const THREE_PERSON_1_2 = preload("res://Sounds/People/three_person_1_2.mp3")
const THREE_PERSON_1_3 = preload("res://Sounds/People/three_person_1_3.mp3")
const THREE_PERSON_2_1 = preload("res://Sounds/People/three_person_2_1.mp3")
const THREE_PERSON_2_2 = preload("res://Sounds/People/three_person_2_2.mp3")
const THREE_PERSON_2_3 = preload("res://Sounds/People/three_person_2_3.mp3")
const THREE_PERSON_3_1 = preload("res://Sounds/People/three_person_3_1.mp3")
const THREE_PERSON_3_2 = preload("res://Sounds/People/three_person_3_2.mp3")
const THREE_PERSON_3_3 = preload("res://Sounds/People/three_person_3_3.mp3")
const THREE_PERSON_4_1 = preload("res://Sounds/People/three_person_4_1.mp3")
const THREE_PERSON_4_2 = preload("res://Sounds/People/three_person_4_2.mp3")
const THREE_PERSON_4_3 = preload("res://Sounds/People/three_person_4_3.mp3")
const THREE_PERSON_5_1 = preload("res://Sounds/People/three_person_5_1.mp3")
const THREE_PERSON_5_2 = preload("res://Sounds/People/three_person_5_2.mp3")
const THREE_PERSON_5_3 = preload("res://Sounds/People/three_person_5_3.mp3")

const SINGLE_PERSON_CONVERSATIONS := [
	[ONE_PERSON_1], [ONE_PERSON_2], [ONE_PERSON_3], [ONE_PERSON_4], [ONE_PERSON_5], [ONE_PERSON_6]
]
const TWO_PERSON_CONVERSATIONS := [
	[TWO_PERSON_1_1, TWO_PERSON_1_2],
	[TWO_PERSON_2_1, TWO_PERSON_2_2],
	[TWO_PERSON_3_1, TWO_PERSON_3_2],
	[TWO_PERSON_4_1, TWO_PERSON_4_2],
	[TWO_PERSON_5_1, TWO_PERSON_5_2],
	[TWO_PERSON_6_1, TWO_PERSON_6_2],
]
const THREE_PERSON_CONVERSATIONS := [
	[THREE_PERSON_1_1, THREE_PERSON_1_2, THREE_PERSON_1_3],
	[THREE_PERSON_2_1, THREE_PERSON_2_2, THREE_PERSON_2_3],
	[THREE_PERSON_3_1, THREE_PERSON_3_2, THREE_PERSON_3_3],
	[THREE_PERSON_4_1, THREE_PERSON_4_2, THREE_PERSON_4_3],
	[THREE_PERSON_5_1, THREE_PERSON_5_2, THREE_PERSON_5_3],
]
