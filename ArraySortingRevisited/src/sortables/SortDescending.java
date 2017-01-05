package sortables;

/**
 * Created by Nick on 2017-01-03.
 */
public class SortDescending<E extends Comparable<? super E>> extends SortBasedOnSomeCriterion<E> {
    private SortDescending() {}

    public static SortDescending newInstance() {
        return new SortDescending();
    }

    @Override
    public boolean isMoreOfAGivenExtreme(E candidate, E curMax) {
        return candidate != null
                && curMax != null
                && candidate.compareTo(curMax) > 0;
    }
}