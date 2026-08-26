"""Reserved entry point for a future foot-roll rig module.

The previous placeholder imported a nonexistent ``base`` module and crashed
package discovery even though it was never registered. Keep an explicit stub
so old imports fail only when someone tries to use the unfinished feature.
"""


class FootRollModule:
    def __init__(self, *args, **kwargs):
        raise NotImplementedError(
            "FootRollModule is not implemented or registered in MayaCraft 2."
        )
