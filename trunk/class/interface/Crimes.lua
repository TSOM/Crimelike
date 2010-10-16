Crimes['Larceny'] = {
class = 'Felony',
notoriety = {"Thief", 10}
description = [[Stealing someone else's possessions without the use of force or fraud.]]
}
(Pretty sure that larceny is up to a certain amount, then it becomes grand larcenry. So we'd need two or more crime entires, based on the total the player stole from one person. -Nen)

Crimes['Robbery'] = {
class = 'Felony',
notoriety = {{"Thief", 10}}
description = [[Stealing someone else's possessions through force or threats of force.]]
}

Crimes['Armed Robbery'] = {
class = 'Felony',
notoriety = {{"Thief", "Violent", 20}}
heatMod = 1.1
description = [[Stealing someone else's possessions through force or threats of force, using a weapon.]]
}

Crimes['Assault] = {
class = 'Misdemeanor',
notoriety = {"Violent", 10}
description = [[An attempt to deliberately or recklessly cause bodily injury to another person.]]
} 

Crimes['Aggravated Assault'] = {
class = 'Felony'
notoriety = {"Violent", 15}
heatMod = 1.2
description = [[An attempt to deliberately intentionally cause severe bodily injury to another person, usually with a deadly weapon.]]
}

Crimes['Grand Theft Auto'] = {
class = 'Felony',
notoriety = {"Theft", 10},
description = [[The act of stealing a motor vehicle.]]
}

Crimes['Arson'] = {
class = 'Felony'
notoriety = {"Sociopath", 15},
heatMod = 1.2,
description = [[The act of deliberately setting fire to a piece of property.]]
}

Crimes['Breaking and Entering'] = {
class = 'Misdemeanor',
notoriety = {"Burglar", 5},
description = [[The act of obtaining unlawful access to a property.]]
}

Crimes['Misdemeanor Burglary'] = {
class = 'Misdemeanor',
notoriety = {"Burglar", 7},
description = [[The act of unlawfully entering another's house AT NIGHT.]]
}

Crimes['Felony Burglary'] = {
class = 'Felony',
notoriety = {"Burglar", 10},
description = [[The act of unlawfully entering another's house AT NIGHT with the intent to commit a felony.]]
}

(A note on Mis/Felony Burlgarly: The definitions are not exact. Basically one punishes B&E during the night time at a higher penalty than day time B&E, and the other punishes the entry at night if other crimes get committed in the process.B&E in most american states gets upgraded to Burglary because the law assumes you broke in at night to do evil things. -Nen)

Crimes['Identity Theft'] = {
class = 'Felony',
notoriety = {"Computer/Hacking", 15},
description = [[The act of obtaining access to, and utilizing, personal information of a person other than yourself without their knowledge.]]
}

Crimes['Misdemanor Narcotics Possession'] = {
class = 'Gross',
notoriety = {"Social/Drug"?, 5},
description = [[The act of possessing illicit substances. Posession of or attempting to purchase a lesser illegal substance in smaller quantities.]]
}
(Entries for drugs at  least should have a list of which drugs this applies to. For MNP, it  would be Pot, non-prescription drugs, fake drugs. -Nen)

Crimes['Felony Narcotics Possession/'] = {      (Needs a better name?)
class = 'Felony',
notoriety = {"Social/Drugs?", 10},
description = [[The act of selling or buying illicit substances. Possession of or attempting to purhcase a highly illegal substance in small quantities.]]
}

Crimes['Intent to Distribute Narcotics'] = {
class = 'Felony',
notoriety = {"Drugs", 10},
description = [[Possession of large amount of illegal substances with the intent to distribute them.]]
}

Crimes['Embezzlement'] = {
class = 'Felony',
notoriety = {"Social"?, 1},
description = [[The act of using a company's funds for personal use, without permission or express knowledge of said company.]]
}

Crimes['Prostitution'] = {
class = 'Misdemeanor',
notoriety = {"Social", 5},
description = [[The act of engaging in acts of a sexual nature for a fee.]]
}

Crimes['Murder'] = {
class = 'Felony',
notoriety = {"Killer", 20},
heatMod = 2,
description = [[The act of intentionally killing another human being.]]
}