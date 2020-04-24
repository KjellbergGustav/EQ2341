# Music Theory

- It's the quotient between two frequencies that decides what is harmonic and pleasant.

- **Fundamental relationship** between two pitches is that one is double the frequency of the other. The interval is known as an **octave**

- In western music one octave is sliced into to 12 **semitones**. The quotient between the pitches of two *adjacent semitones* is always the same, making them equally spaced on a logarithmic scale.

- In western music a sequence of notes if formed by **concatenating a number of stretches of semitones** with different *durations*, that may also include silent segments.

- Any interval between notes that is not close to an integer number of semitones may be perceived as being out of tune.

- Logarithmic scale - we need to take account for that in our features. (Base the features on the log of the pitch track)

- The distinct semitones allows us to represent the sound as discrete.

- The offset of the pitch track should not matter.
  
  - Another vital aspect of music perception is that most people, possibly
    excluding those with perfect pitch, still perceive the same melody if all notes
    in it are transposed (moved) the same number of semitones up or down on
    the scale. This need not be an integer number of semitones, either, just as
    long as the frequency ratios always remain unchanged. It is therefore crucial
    to devise a feature extractor where the output remains largely unchanged if
    the entire input is transposed up or down by an arbitrary amount.

- Logarithm of the sound intensity as well.

- 
