<note>

	<div class="note { toggledOn:note.play } { cue:cue }" onclick={ toggleNote }></div>

	<script>
        var tag = this;
		this.room = opts.room;
		this.isUser = opts.isUser;
		this.roomUser = opts.roomUser;
		this.cue = false;
        this.notes=[]


		toggleNote(event) {
			if (this.isUser) {
				let roomUserDoc = database.collection('sound-rooms/' + this.room.id + '/users').doc(this.roomUser.id);
				this.roomUser.notes[this.i].play = !this.roomUser.notes[this.i].play;
				roomUserDoc.update(this.roomUser);
                 console.log('iiii',this.i)

                if (this.roomUser.notes[this.i].play){
                    this.note = this.roomUser.note
                    this.noteNumber=this.i+""

                    console.log('nooooo',this.note)
                    let musicRef = database.collection('sound-rooms').doc(this.room.id).collection('music').doc(this.noteNumber);
                    musicRef.get().then(function(doc){
                      var note = doc.data()

                      // tag.note.push(note)
                      console.log('note',tag.note)
                    })

                    musicRef.set({
                        notes:tag.note
                    })
                }


			}
		}
		observer.on('onBeat', beatIndex => {
			console.log('x')
			if (this.i === beatIndex) {
				this.cue = true;
			} else {
				this.cue = false;
			}
			this.update();
		})

		this.on('update', () => {
			this.isUser = opts.isUser;
			this.room = opts.room;
			this.roomUser = opts.roomUser;
		});
	</script>

	<style>

		.note {
			display: inline-block;
			width: 2em;
			height: 2em;
			background-color: silver;
			margin-right: 0.25em;
		}
		.toggledOn {
			background-color: orange;
		}
		.cue {
			outline: 2px solid turquoise;
		}
	</style>
</note>
