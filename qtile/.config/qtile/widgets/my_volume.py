from libqtile import widget


class MyVolume(widget.Volume):
    """Widget that display the volume + emoji"""

    def _configure(self, qtile, bar):
        widget.Volume._configure(self, qtile, bar)
        self._update_drawer()

    def _update_drawer(self):
        vol = self.get_volume()

        if vol <= 0:
            self.text = "🔇"
            return

        if vol >= 75:
            self.text = "🔊{}%".format(vol)
        elif vol >= 30:
            self.text = "🔉{}%".format(vol)
        else:
            self.text = "🔈{}%".format(vol)

        self.draw()
