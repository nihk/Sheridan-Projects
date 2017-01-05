package sortables;

/**
 * Created by Nick on 2017-01-03.
 */
public class SortAscending<E extends Comparable<? super E>> extends SortBasedOnSomeCriterion<E> {
    private SortAscending() {}

    public static SortAscending newInstance() {
        return new SortAscending();
    }

    @Override
    public boolean isMoreOfAGivenExtreme(E candidate, E curMin) {
        return candidate != null
                && curMin != null
                && candidate.compareTo(curMin) < 0;
    }
}