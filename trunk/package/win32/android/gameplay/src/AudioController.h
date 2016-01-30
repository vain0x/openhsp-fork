#ifndef AUDIOCONTROLLER_H_
#define AUDIOCONTROLLER_H_

namespace gameplay
{


/**
 * Defines a class for controlling game audio.
 */
class AudioController
{

public:
    
    /**
     * Destructor.
     */
    virtual ~AudioController();

private:
    
    /**
     * Constructor.
     */
    AudioController();

    /**
     * Controller initialize.
     */
    void initialize();

    /**
     * Controller finalize.
     */
    void finalize();

    /**
     * Controller pause.
     */
    void pause();

    /**
     * Controller resume.
     */
    void resume();

    /**
     * Controller update.
     */
    void update(float elapsedTime);


};

}

#endif
