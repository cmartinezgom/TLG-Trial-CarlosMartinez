// Technical Trial Task for Tavernlight Games Software Developer role
// by Carlos Martínez

// Q4 - Assume all method calls work fine.Fix the memory leak issue in below method

// The memory leak issue arises because we are allocating memory for a Player object


// function that gives an item to a player, regardless they are online or offline
void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
	// [MEMORY LEAK] track if we needed to allocate memory
	bool createdPlayer = false;

	// retrieve player by name
	Player* player = g_game.getPlayerByName(recipient);
	
	// check if we got the player
	if (!player) {
		// no player found, create player object
		player = new Player(nullptr);
		createdPlayer = true;

		// attempt to load player data by name
		if (!IOLoginData::loadPlayerByName(player, recipient)) {
			// no player data could be loaded, exit
			// [MEMORY LEAK] free allocated memory
			delete player;
			return;
		}
	}

	// after this point player has been loaded successfully

	// create an item from provided itemId
	Item* item = Item::CreateItem(itemId);
	if (!item) {
		// item creation failed, exit
		// [MEMORY LEAK] free allocated memory if needed
		if (createdPlayer) {
			delete player;
		}
		return;
	}

	// successfully created item, add it to player's inbox
	g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

	// save player if they are offline
	if (player->isOffline()) {
		IOLoginData::savePlayer(player);
	}

	// [MEMORY LEAK] free allocated memory if needed
	if (createdPlayer) {
		delete player;
	}
}