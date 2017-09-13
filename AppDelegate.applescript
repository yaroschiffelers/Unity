--
--  AppDelegate.applescript
--  CAppleSrcObC
--
--  Created by Yaro Schiffelers on 09-07-17.
--  Copyright © 2017 Yaro Schiffelers. All rights reserved.
--

-- ###########
-- TODO
-- ###########

-- * Refine Spotifyplaylist(), replace hardcoded delay with something like: while "spotify" is loading: wait, if "spotify" is done loading "play" --> see DevNotes for try-out func
-- * Set window bounds
-- * optimize script with func lib -- import lib here
-- * Find out how to add, compile and run applescript in objective-c cocoa app (also: how to change the script form Unity's UI)
-- * Make editing Spotify Playlist URL's posible from UI (var, set, change, save, call on start)
-- * Find: browers open new tab with url X command (instead of: do shell script "open URL)
-- * Find out why running iTerm.app makes the build fail (do shell script -a appname) (tell application "iTerm" to activate 

-- ###########
-- End TO DO
-- ###########

script AppDelegate
    property parent : class "NSObject"

	-- IBOutlets
	property theWindow : missing value
    
    -- IBOutlet onOffButton_(()
    property onOffButton : missing value

	on applicationWillFinishLaunching_(aNotification)
		-- Insert code here to initialize your application before any files are opened 
	end applicationWillFinishLaunching_
	
	on applicationShouldTerminate_(sender)
		-- Insert code here to do any housekeeping before your application quits 
		return current application's NSTerminateNow
	end applicationShouldTerminate_
    
    -- Terminate App if (x) icon is pressed
    on applicationShouldTerminateAfterLastWindowClosed_(sender)
        return yes
    end applicationShouldTerminateAfterLastWindowClosed_

    -- State of onOffButton_()
    property onOffValue : missing value
    
    -- Exeptions for closeAppsHard(PROPERTYNAME)
    property closeApps1 : {"xcode", "google chrome", "unity"}
    property closeApps2 : {"xcode", "google chrome", "unity", "finder"}
    
    -- Spotify playlist urls
    property spotifyNexus : {"spotify:user:spotify:playlist:37i9dQZF1DWXCIgX3kyeVF"}
    property spotifyPiano : {"spotify:user:spotify:playlist:37i9dQZF1DXah8e1pvF5oE"}
    property spotifyPleinvrees : {"spotify:user:pleinvrees:playlist:2ddJSdQkd65wSnTWZFAdx6"}
    property spotifyRapCaviar : {"spotify:user:spotify:playlist:37i9dQZF1DX0XUsuxWHRQd"}
    property spotifyWorld50 : {"spotify:user:spotifycharts:playlist:37i9dQZEVXbLiRSasKsNU9"}
    
    -- ###########
    -- Functions
    -- ###########
    
    -- OnOffButton: control value for closeAppsHard_()
    on onOffButton_(sender)
        set onOffValue to (onOffButton's state())
    end onOffButton_
    
    -- Delay
    on delay_(a)
        repeat a times
            current application's NSThread's sleepForTimeInterval:1
        end repeat
    end delay_
    
    -- Deactivates any other open app
    on closeAppsHard_(a)
        if onOffValue is 1 -- checks state of OnOffButton
            tell application "System Events" to set openapps to name of every application process whose visible is true and name is not "Finder"
            -- exeptions
            set keepapp to {}
            set keepapp to keepapp & a
            -- close apps
            repeat with closeapps in openapps
                if closeapps is not in keepapp then quit application closeapps
            end repeat
        else
            -- if buttonstate is off(0) then do nothing when this func is called
        end if
    end closeAppsHard_
    
    -- SpotifyPlaylist(a) refer in func property to spotifyurl property name. Example: SpotifyPlayList(SpotifyNexus)
    on spotifyPlaylist_(a)
        tell application "System Events"
            get name of every process whose name is "Spotify"
            if result is not {} then
                tell application "Spotify"
                    set shuffling to false
                    set shuffling to true
                    play track a
                end tell
            else
                tell application "Spotify" to launch
                my delay_(5)
                tell application "Spotify"
                    set shuffling to false
                    set shuffling to true
                    play track a
                end tell
            end if
        end tell
    end SpotifyPlaylist_
    
    -- ###########
    -- End of functions
    -- ###########


    -- ###########
    -- Button Applescript actions (IBActions)
    -- ###########
    
    -- NEXUS: Activate playlist Nexus on Spotify
    on pushPlaylistNexus_(sender)
        activate
        spotifyPlaylist_(SpotifyNexus)
    end pushPlaylistNexus_
    
    -- PIANO: Activate playlist Piano on Spotify
    on pushPlaylistPiano_(sender)
        activate
        spotifyPlaylist_(spotifyPiano)
    end pushPlaylistPiano_
    
    -- PLEINVREES: Activate playlist Pleinvrees on Spotify
    on pushPlaylistPleinvrees_(sender)
        activate
        spotifyPlaylist_(spotifyPleinvrees)
    end pushPlaylistPleinvrees_
    
    -- RAPCAVIAR: Activate playlist RapCaviar on Spotify
    on pushPlaylistRap_(sender)
        activate
        spotifyPlaylist_(spotifyRapCaviar)
    end pushPlaylistRap_
    
    -- WORLD 50: Activate playlist World50 on Spotify
    on pushPlaylistWorld_(sender)
        activate
        spotifyPlaylist_(spotifyWorld50)
    end pushPlaylistWorld_
    
    -- MOOD: Open new tab in browser and navigate to URL
    on pushMood_(sender)
        activate
        do shell script "open http://www.youtubemultiplier.com/5209b0d29dbdc-rainy-mood-godot-fireplace.php"
    end pushMood_
    
    -- BASH: Bash button. Runs: Bash-shell, SublimeText2, Opera opens bash page on stackoverflow, Finder opens bash dir
    on pushBash_(sender)
        activate
        closeAppsHard_(closeApps2)
        
        -- open Sublime Text 2 fullscreen
        tell application "Sublime Text" to activate
        my delay_(1)
        
        -- fullscreen sublime text
        tell application "System Events"
            keystroke "f" using {control down, command down}
        end tell
        
        my delay_(2)
        
        -- open stackoverflow in default browser
        do shell script "open https://stackoverflow.com/documentation/bash/topics"
        my delay_(2)
        
        -- full screen webbrowser
        tell application "System Events"
            keystroke "f" using {control down, command down}
        end tell
        
        -- open finder dir bash
        do shell script "open /Users/yaroschiffelers/Programeren/Bash"
        
    end pushBash_
    
    -- WEB
    on pushWeb_(sender)
        activate
        closeAppsHard_(closeApps2)
        
        -- activate Sublime Text
        tell application "Sublime Text" to activate
        my delay_(1)
        
        -- make Sublime Text fullscreen
        tell application "System Events"
            keystroke "f" using {control down, command down}
        end tell
        
        -- open Web dir
        do shell script "open /Users/yaroschiffelers/Programeren/Web"
        
        -- open stackoverflow html documentation in default browser
        do shell script "open https://stackoverflow.com/documentation/html/topics"
        
        -- open web dir in default browser (only opens file in browser if this filetype is set to open with a browser)
        do shell script "open file:///Users/yaroschiffelers/Programeren/Web/"
        my delay_(2)
        
        -- full screen webbrowser
        tell application "System Events"
            keystroke "f" using {control down, command down}
        end tell
        
            #TODO:
            #        -- activate iTerm with profile WEB
            #        tell application "iTerm" to activate
            #            set newWindow to create window with profile "Web"
            #        end tell

    end pushWeb_
    
    -- ARDUINO
    on pushArduino_(sender)
        activate
        closeAppsHard(closeApps2)
        
    end pushArduino_
    
    -- XCODE
    on pushXcode_(sender)
        activate
        closeAppsHard(closeApps2)
        
    end pushXcode_
    
    -- XYZ
    on pushXYZ_(sender)
        activate
        closeAppsHard(closeApps2)
        
    end pushXYZ_
    

    -- STUDIE
    on pushStudie_(sender)
        activate
        closeAppsHard(closeApps2)
        tell application "Sublime Text 2" to activate
        do shell script "open /Users/yaroschiffelers"
    end pushStudie_
    
    -- FINANCIËN
    on pushFinanc_(sender)
        activate
        closeAppsHard(closeApps2)
    end pushFinanc_
    
    -- SCHRIJVEN
    on pushSchrijven_(sender)
        activate
        closeAppsHard(closeApps2)
    end pushSchrijven_
    
    -- ONTWERPEN
    on pushOntwerpen_(sender)
        activate
        closeAppsHard(closeApps2)
    end pushOntwerpen_
    
    -- PROJECTPLANNING
    on pushProjectPlanning_(sender)
        activate
        closeAppsHard(closeApps2)
    end pushProjectPanning_
    
    -- BACKUP
    on pushBackup_(sender)
        activate
        closeAppsHard(closeApps2)
    end pushBackup_
    
    -- PLANNING
    on pushPlanning_(sender)
        activate
        closeAppsHard(closeApps2)
    end pushPlanning_

end script
