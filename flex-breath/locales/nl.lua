local Translations = {
    error = {
        nobodynear = 'Niemand in de buurd om een test af te nemen..',
        getcloser = 'Ga dichter staan om de test af te nemen..',
        stoppedbreath = 'Gestopt met blazen..',
    },
    success = {
        breath = 'Lang genoeg geblazen. Resultaten zijn beschikbaar!'
    },
    info = {
        breathing = 'Aan het blazen..'
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
