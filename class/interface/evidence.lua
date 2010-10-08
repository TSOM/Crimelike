EvidenceTypes = {}

--Key = Name
--evType = Physical, Witness,
--weightMod = A multiplier for how much weight this evidence type has.
EvidenceTypes['Fingerprint'] = {
evType = 'Physical',
weightMod = 1
}

EvidenceTypes['DNA'] = {
evType = 'Physical',
weightMod = 1.75
}

EvidenceTypes['Physical'] = {
evType = 'Physical',
weightMod = 0.5
}

EvidenceTypes['Video'] = {
evType = 'Physical',
weightMod = 1.5
}

EvidenceTypes['Audio'] = {
evType = 'Physical',
weightMod = 1
}

EvidenceTypes['Weapon'] = {
evType = 'Physical',
weightMod = 1
}

EvidenceTypes['Testimony'] = {
evType = 'Witness',
weightMod = 1
}

